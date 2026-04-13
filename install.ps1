param(
    [string]$CodexHome = "$env:USERPROFILE\.codex",
    [string]$AgentsHome = "$env:USERPROFILE\.agents",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceRoot = Join-Path $repoRoot "skills"
$codexSkillsRoot = Join-Path $CodexHome "skills"
$agentsSkillsRoot = Join-Path $AgentsHome "skills"

if (-not (Test-Path $sourceRoot)) {
    throw "Missing source skills directory: $sourceRoot"
}

New-Item -ItemType Directory -Force -Path $codexSkillsRoot | Out-Null
New-Item -ItemType Directory -Force -Path $agentsSkillsRoot | Out-Null

$skills = Get-ChildItem $sourceRoot -Directory | Sort-Object Name

if (-not $skills) {
    throw "No skill directories found under: $sourceRoot"
}

foreach ($skill in $skills) {
    $dest = Join-Path $codexSkillsRoot $skill.Name
    $link = Join-Path $agentsSkillsRoot $skill.Name

    if (Test-Path $dest) {
        if (-not $Force) {
            throw "Destination already exists: $dest. Re-run with -Force to replace."
        }

        Remove-Item -LiteralPath $dest -Recurse -Force
    }

    Copy-Item -LiteralPath $skill.FullName -Destination $dest -Recurse -Force

    if (Test-Path $link) {
        if (-not $Force) {
            throw "Skill link already exists: $link. Re-run with -Force to replace."
        }

        $linkItem = Get-Item -LiteralPath $link -Force
        if ($linkItem.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            # Remove-Item -Force throws on non-empty directory junctions in this environment.
            [System.IO.Directory]::Delete($link)
        } else {
            Remove-Item -LiteralPath $link -Recurse -Force
        }
    }

    New-Item -ItemType Junction -Path $link -Target $dest | Out-Null
    Write-Host "Installed $($skill.Name)"
}

Write-Host ""
Write-Host "Installed $($skills.Count) skills."
Write-Host "Codex copy root: $codexSkillsRoot"
Write-Host "Native discovery root: $agentsSkillsRoot"
