# codex-game-studio

Codex adaptation of the original `Claude-Code-Game-Studios` template.

This repo packages the migrated `ccgs-*` skill set that was adapted for Codex and verified on Windows, plus a Windows cleanup utility skill.

## Included

- `40` Codex skills with the `ccgs-` prefix
- `1` Windows utility skill: `windows-c-drive-cleanup`
- shared `ccgs-studio` reference pack
- `install.ps1` to install all packaged skills into the local Codex skill locations

## Upstream Attribution

This package is derived from:

- `https://github.com/Donchitos/Claude-Code-Game-Studios`

The original project is licensed under MIT. See `LICENSE` and `NOTICE.md`.

## Repository Layout

- `skills/ccgs-*`
  - migrated Codex skills
- `skills/windows-c-drive-cleanup`
  - Windows C drive cleanup skill with a reusable PowerShell script
- `skills/ccgs-studio/references/repo`
  - imported upstream reference pack used by the migrated skills
- `install.ps1`
  - copies the skills into the local Codex home and creates the native discovery links

## Install On Windows

From the repository root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

This installer does two things:

1. Copies all packaged skills into:
   - `%USERPROFILE%\.codex\skills`
2. Creates Junction links for native Codex discovery in:
   - `%USERPROFILE%\.agents\skills`

That second step matters because fresh native `codex.cmd` processes were validated against the `%USERPROFILE%\.agents\skills` discovery path.

## Force Reinstall

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Force
```

## Verified State

This pack was verified with:

- `41/41` packaged skill directories passing frontmatter validation
- the new `windows-c-drive-cleanup` script producing valid preview output on Windows
- an existing `codex.cmd exec` validation pass for representative discovery and execution in this pack
- representative workflow execution succeeding for `ccgs-project-stage-detect`

## Key Skills

- `ccgs-studio`
- `ccgs-start`
- `ccgs-project-stage-detect`
- `ccgs-agent-orchestration`
- `ccgs-quality-gates`
- `windows-c-drive-cleanup`

## Notes

- This repo mainly packages the migrated Codex-facing `ccgs-*` skills plus one Windows utility skill.
- It does not bundle unrelated local personal skills from the original machine.
- Some workflows assume a normal Codex environment with standard built-in tools available.
