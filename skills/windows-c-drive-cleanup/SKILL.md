---
name: windows-c-drive-cleanup
description: Use when the user wants to free space on a Windows C drive by deleting temporary files, safe caches, recycle bin contents, or Downloads files older than a cutoff. Appropriate for Windows disk cleanup requests that mention temp files, stale Downloads content, or common C drive cleanup logic.
---

# Windows C Drive Cleanup

Use this skill to run a safe Windows C drive cleanup that follows the common logic of mainstream cleanup tools: inspect first, then delete only from an approved set of temporary folders, safe caches, recycle bin contents, and old Downloads files.

## Safety Rules

- Stay inside this approved target set only:
  - `C:\Windows\Temp`
  - `C:\Users\<user>\AppData\Local\Temp`
  - `C:\Windows\SoftwareDistribution\Download`
  - `C:\Users\<user>\AppData\Local\D3DSCache`
  - `C:\Users\<user>\AppData\Local\CrashDumps`
  - `C:\ProgramData\Microsoft\Windows\WER`
  - `C:\Users\<user>\AppData\Local\Microsoft\Windows\Explorer\thumbcache*`
  - `C:\Users\<user>\Downloads` files older than the cutoff
  - `C:\$Recycle.Bin`
- Treat Downloads age by `LastWriteTime`, not `LastAccessTime`.
- Skip these risky areas by default and report them as excluded:
  - `C:\ProgramData\Package Cache`
  - `C:\Windows\Installer`
  - browser profiles, application data stores, and any path outside the approved list
- If files are locked, skip them and report the remaining size instead of forcing destructive workarounds.

## Workflow

1. Inventory first.
Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\cleanup_c_drive.ps1 -CutoffDays 30
```

2. Apply only when the user explicitly asked to delete files.
If the request is already explicit, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\cleanup_c_drive.ps1 -CutoffDays 30 -Apply
```

3. Summarize the result.
Report:
- total candidate size in preview, or total freed space after apply
- which paths were cleaned
- which paths were intentionally excluded
- what remains because Windows or another app still has files open

4. Recommend a reboot only when locked temp files remain.

## Script Output

The bundled script prints a JSON object with:

- `mode`
- `cutoffDate`
- `beforeFreeGB`
- `afterFreeGB`
- `totalFreedGB`
- `targets`
- `exclusions`
- `errors`

Use `targets[*].eligibleGB` for preview summaries and `targets[*].freedGB` plus `totalFreedGB` for applied cleanup summaries.

## Default Cutoff

- Use `30` days for Downloads unless the user gives a different age threshold.
- Keep the rest of the cleanup scope unchanged unless the user explicitly broadens it.

## Examples

- "Clean my C drive like Disk Cleanup. Delete temp files and Downloads files older than 30 days."
- "Free some C drive space on Windows, but stay with safe cleanup targets."
- "Delete temporary files, clear recycle bin, and remove old installer files from Downloads."
