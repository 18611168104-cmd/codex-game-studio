# codex-game-studio

Codex adaptation of the original `Claude-Code-Game-Studios` template.

This repo packages the migrated `ccgs-*` skill set that was adapted for Codex and verified on Windows.

## Included

- `40` Codex skills with the `ccgs-` prefix
- shared `ccgs-studio` reference pack
- `install.ps1` to install the skills into the local Codex skill locations

## Upstream Attribution

This package is derived from:

- `https://github.com/Donchitos/Claude-Code-Game-Studios`

The original project is licensed under MIT. See `LICENSE` and `NOTICE.md`.

## Repository Layout

- `skills/ccgs-*`
  - migrated Codex skills
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

1. Copies all `ccgs-*` skills into:
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

- `40/40` migrated `ccgs-*` skill directories passing frontmatter validation
- a fresh `codex.cmd exec` process discovering all `40` skills
- representative workflow execution succeeding for `ccgs-project-stage-detect`

## Key Skills

- `ccgs-studio`
- `ccgs-start`
- `ccgs-project-stage-detect`
- `ccgs-agent-orchestration`
- `ccgs-quality-gates`

## Notes

- This repo packages only the migrated Codex-facing `ccgs-*` skills.
- It does not bundle unrelated local personal skills from the original machine.
- Some workflows assume a normal Codex environment with standard built-in tools available.
