---
name: ccgs-studio
description: "Use when the user wants the imported Claude Code Game Studios pack in Codex, needs an overview of the migrated game-development workflows, or needs the shared references, templates, agent roster, rules, hooks, and studio documentation."
---

# CCGS Studio

Codex adaptation of the `Claude Code Game Studios` template installed from:
`C:\Users\18143\Claude-Code-Game-Studios`

The imported reference pack lives at:
`C:\Users\18143\.codex\skills\ccgs-studio\references\repo`

## What Was Migrated

- `37` workflow skills from `.claude/skills`
- `48` role definitions from `.claude/agents`
- shared docs, templates, rules, hooks, and setup notes from `.claude/docs`, `.claude/rules`, `.claude/hooks`, `docs`, and `production`

## Codex Adaptation Rules

- All imported workflows were renamed with a `ccgs-` prefix. Example: `/start` became `ccgs-start`.
- Claude-only tool names in the original docs map to Codex equivalents:
  - `Read`, `Glob`, `Grep` -> `shell_command` with `Get-Content` / `rg`
  - `Write` -> `apply_patch`
  - `WebSearch` -> `web`
  - `AskUserQuestion` -> ask the user directly with one concise plain-text question
- Imported `.claude/agents` files are reference material only. Codex does not auto-load them as runnable local agents.
- Imported hooks and path rules are not auto-enforced in Codex. Use `ccgs-quality-gates` to apply them manually.
- For studio-style delegation in Codex, use `ccgs-agent-orchestration` and only spawn subagents when the user explicitly asks for delegation or parallel agent work.

## Migrated Workflow Skills

- `ccgs-architecture-decision`
- `ccgs-asset-audit`
- `ccgs-balance-check`
- `ccgs-brainstorm`
- `ccgs-bug-report`
- `ccgs-changelog`
- `ccgs-code-review`
- `ccgs-design-review`
- `ccgs-design-system`
- `ccgs-estimate`
- `ccgs-gate-check`
- `ccgs-hotfix`
- `ccgs-launch-checklist`
- `ccgs-localize`
- `ccgs-map-systems`
- `ccgs-milestone-review`
- `ccgs-onboard`
- `ccgs-patch-notes`
- `ccgs-perf-profile`
- `ccgs-playtest-report`
- `ccgs-project-stage-detect`
- `ccgs-prototype`
- `ccgs-release-checklist`
- `ccgs-retrospective`
- `ccgs-reverse-document`
- `ccgs-scope-check`
- `ccgs-setup-engine`
- `ccgs-sprint-plan`
- `ccgs-start`
- `ccgs-team-audio`
- `ccgs-team-combat`
- `ccgs-team-level`
- `ccgs-team-narrative`
- `ccgs-team-polish`
- `ccgs-team-release`
- `ccgs-team-ui`
- `ccgs-tech-debt`

## Reference Paths

- Agent roster: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\agents`
- Shared docs: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\docs`
- Path rules: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules`
- Hook scripts: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\hooks`
- Project-level guide: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\CLAUDE.md`
- Main README: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\README.md`
- Upgrade notes: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\UPGRADING.md`

## Recommended Use Order

1. `ccgs-start` for onboarding into the imported studio flow.
2. `ccgs-brainstorm` or `ccgs-project-stage-detect` depending on whether the project is new or existing.
3. `ccgs-design-system`, `ccgs-map-systems`, `ccgs-architecture-decision`, and `ccgs-sprint-plan` to structure work.
4. `ccgs-agent-orchestration` only when you need role-based studio delegation in Codex.
5. `ccgs-quality-gates` before claiming milestones, reviews, release readiness, or production handoffs.
