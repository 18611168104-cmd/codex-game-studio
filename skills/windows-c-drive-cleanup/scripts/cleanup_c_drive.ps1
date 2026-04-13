param(
    [int]$CutoffDays = 30,
    [switch]$Apply
)

$ErrorActionPreference = "SilentlyContinue"

function Convert-ToRoundedGB {
    param([long]$Bytes)

    if (-not $Bytes) {
        return 0
    }

    return [math]::Round(($Bytes / 1GB), 2)
}

function Get-FileList {
    param(
        [string]$Path,
        [string]$Filter
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return @()
    }

    if ($Filter) {
        return @(Get-ChildItem -LiteralPath $Path -Force -File -Filter $Filter -ErrorAction SilentlyContinue)
    }

    return @(Get-ChildItem -LiteralPath $Path -Force -Recurse -File -ErrorAction SilentlyContinue)
}

function Get-FileSummary {
    param([object[]]$Files)

    $measure = $Files | Measure-Object Length -Sum
    return [pscustomobject]@{
        Count = ($Files | Measure-Object).Count
        Bytes = [long]($measure.Sum)
        GB    = Convert-ToRoundedGB ([long]$measure.Sum)
    }
}

function Resolve-ApprovedPath {
    param(
        [string]$Path,
        [string[]]$AllowedPaths
    )

    $resolved = [System.IO.Path]::GetFullPath($Path).TrimEnd("\")
    if ($resolved -notin $AllowedPaths) {
        throw "Path is outside approved scope: $resolved"
    }

    return $resolved
}

function Remove-DirectoryContents {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        return
    }

    foreach ($item in (Get-ChildItem -LiteralPath $Path -Force -ErrorAction SilentlyContinue)) {
        try {
            Remove-Item -LiteralPath $item.FullName -Recurse -Force -ErrorAction Stop
        } catch {
        }
    }
}

function Remove-Files {
    param([object[]]$Files)

    foreach ($file in $Files) {
        try {
            Remove-Item -LiteralPath $file.FullName -Force -ErrorAction Stop
        } catch {
        }
    }
}

function Remove-EmptyDirectories {
    param([string]$RootPath)

    if (-not (Test-Path -LiteralPath $RootPath)) {
        return
    }

    Get-ChildItem -LiteralPath $RootPath -Force -Recurse -Directory -ErrorAction SilentlyContinue |
        Sort-Object FullName -Descending |
        ForEach-Object {
            try {
                if (-not (Get-ChildItem -LiteralPath $_.FullName -Force -ErrorAction Stop)) {
                    Remove-Item -LiteralPath $_.FullName -Force -ErrorAction Stop
                }
            } catch {
            }
        }
}

function Get-TargetReport {
    param(
        [string]$Id,
        [string]$Category,
        [string]$Path,
        [string]$Scope,
        [string]$Filter,
        [datetime]$CutoffDate,
        [switch]$ApplyChanges
    )

    $beforeFiles = @()
    $afterFiles = @()
    $notes = @()

    switch ($Category) {
        "directory" {
            $beforeFiles = Get-FileList -Path $Path
            if ($ApplyChanges) {
                Remove-DirectoryContents -Path $Path
            }
            $afterFiles = Get-FileList -Path $Path
        }
        "downloads-older" {
            $beforeFiles = @(Get-FileList -Path $Path | Where-Object { $_.LastWriteTime -lt $CutoffDate })
            if ($ApplyChanges) {
                Remove-Files -Files $beforeFiles
                Remove-EmptyDirectories -RootPath $Path
            }
            $afterFiles = @(Get-FileList -Path $Path | Where-Object { $_.LastWriteTime -lt $CutoffDate })
            $notes += "Uses LastWriteTime for the age cutoff."
        }
        "file-glob" {
            $beforeFiles = Get-FileList -Path $Path -Filter $Filter
            if ($ApplyChanges) {
                Remove-Files -Files $beforeFiles
            }
            $afterFiles = Get-FileList -Path $Path -Filter $Filter
        }
        "recycle-bin" {
            $beforeFiles = Get-FileList -Path $Path
            if ($ApplyChanges) {
                try {
                    Clear-RecycleBin -DriveLetter C -Force -ErrorAction Stop | Out-Null
                } catch {
                    Remove-DirectoryContents -Path $Path
                }
            }
            $afterFiles = Get-FileList -Path $Path
        }
        default {
            throw "Unknown category: $Category"
        }
    }

    $beforeSummary = Get-FileSummary -Files $beforeFiles
    $afterSummary = Get-FileSummary -Files $afterFiles

    return [pscustomobject]@{
        id                 = $Id
        path               = $Path
        category           = $Category
        scope              = $Scope
        eligibleCount      = $beforeSummary.Count
        eligibleGB         = $beforeSummary.GB
        deletedCount       = if ($ApplyChanges) { [math]::Max(0, $beforeSummary.Count - $afterSummary.Count) } else { 0 }
        freedGB            = if ($ApplyChanges) { Convert-ToRoundedGB ($beforeSummary.Bytes - $afterSummary.Bytes) } else { 0 }
        remainingEligibleCount = $afterSummary.Count
        remainingEligibleGB    = $afterSummary.GB
        notes              = $notes
    }
}

$downloadsPath = Join-Path $env:USERPROFILE "Downloads"
$localTempPath = Join-Path $env:LOCALAPPDATA "Temp"
$d3dCachePath = Join-Path $env:LOCALAPPDATA "D3DSCache"
$crashDumpPath = Join-Path $env:LOCALAPPDATA "CrashDumps"
$thumbCacheDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Explorer"
$recycleBinPath = 'C:\$Recycle.Bin'

$targets = @(
    [pscustomobject]@{ id = "windows-temp"; category = "directory"; path = "C:\Windows\Temp"; scope = "All files under Windows Temp" },
    [pscustomobject]@{ id = "user-temp"; category = "directory"; path = $localTempPath; scope = "All files under the current user's Temp folder" },
    [pscustomobject]@{ id = "software-distribution-download"; category = "directory"; path = "C:\Windows\SoftwareDistribution\Download"; scope = "Windows Update download cache" },
    [pscustomobject]@{ id = "d3d-cache"; category = "directory"; path = $d3dCachePath; scope = "Direct3D shader cache" },
    [pscustomobject]@{ id = "crash-dumps"; category = "directory"; path = $crashDumpPath; scope = "Crash dump files" },
    [pscustomobject]@{ id = "wer"; category = "directory"; path = "C:\ProgramData\Microsoft\Windows\WER"; scope = "Windows Error Reporting cache" },
    [pscustomobject]@{ id = "downloads-older-than-cutoff"; category = "downloads-older"; path = $downloadsPath; scope = "Downloads files older than the cutoff" },
    [pscustomobject]@{ id = "recycle-bin"; category = "recycle-bin"; path = $recycleBinPath; scope = "Recycle Bin contents" },
    [pscustomobject]@{ id = "explorer-thumbcache"; category = "file-glob"; path = $thumbCacheDir; scope = "Explorer thumbnail cache files"; filter = "thumbcache*" }
)

$approvedPaths = @(
    "C:\Windows\Temp",
    $localTempPath,
    "C:\Windows\SoftwareDistribution\Download",
    $d3dCachePath,
    $crashDumpPath,
    "C:\ProgramData\Microsoft\Windows\WER",
    $downloadsPath,
    $recycleBinPath,
    $thumbCacheDir
) | ForEach-Object {
    [System.IO.Path]::GetFullPath($_).TrimEnd("\")
} | Sort-Object -Unique

$cutoffDate = (Get-Date).Date.AddDays(-$CutoffDays)
$beforeFree = (Get-PSDrive -Name C).Free
$reports = @()
$errors = @()

foreach ($target in $targets) {
    try {
        $resolvedPath = Resolve-ApprovedPath -Path $target.path -AllowedPaths $approvedPaths
        $reports += Get-TargetReport `
            -Id $target.id `
            -Category $target.category `
            -Path $resolvedPath `
            -Scope $target.scope `
            -Filter $target.filter `
            -CutoffDate $cutoffDate `
            -ApplyChanges:$Apply
    } catch {
        $errors += [pscustomobject]@{
            target = $target.id
            path   = $target.path
            error  = $_.Exception.Message
        }
    }
}

$afterFree = (Get-PSDrive -Name C).Free

$result = [pscustomobject]@{
    mode         = if ($Apply) { "apply" } else { "preview" }
    cutoffDays   = $CutoffDays
    cutoffDate   = $cutoffDate.ToString("yyyy-MM-dd")
    beforeFreeGB = Convert-ToRoundedGB $beforeFree
    afterFreeGB  = Convert-ToRoundedGB $afterFree
    totalFreedGB = if ($Apply) { Convert-ToRoundedGB ($afterFree - $beforeFree) } else { 0 }
    targets      = $reports
    exclusions   = @(
        [pscustomobject]@{ path = "C:\ProgramData\Package Cache"; reason = "Excluded by default because uninstall and repair flows can depend on it." },
        [pscustomobject]@{ path = "C:\Windows\Installer"; reason = "Excluded by default because Windows Installer uses it for repair and uninstall." }
    )
    errors       = $errors
}

$result | ConvertTo-Json -Depth 6
