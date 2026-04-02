---
name: ccgs-quality-gates
description: "Use when the user wants Codex to apply the imported Claude Code Game Studios hooks, path rules, review gates, or production checklists manually, especially before reviews, milestones, releases, commits, or cross-discipline handoffs."
---

# CCGS Quality Gates

Use this skill to manually apply the quality controls that were automatic in the original Claude Code Game Studios template.

Imported references live at:
- Hooks: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\hooks`
- Rules: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules`
- Review workflow docs: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\docs\review-workflow.md`
- Coding standards: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\docs\coding-standards.md`
- Templates: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\docs\templates`

## Core Adaptation Rule

The imported hooks and path rules are not auto-enforced in Codex.
You must apply them deliberately.

## Manual Gate Workflow

1. Identify the work area.
2. Read the matching imported rule files.
3. Apply the rule logic during implementation and review.
4. Before any completion claim, run the real verification commands.
5. Report the result with evidence.

## Imported Rule Areas

- Gameplay: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\gameplay-code.md`
- Engine/core: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\engine-code.md`
- AI systems: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\ai-code.md`
- Networking: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\network-code.md`
- UI: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\ui-code.md`
- Design docs: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\design-docs.md`
- Tests: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\test-standards.md`
- Prototypes: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\prototype-code.md`
- Data files: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\rules\data-files.md`

## Hook Translation

Treat these imported hook scripts as checklists, not automatic automations:
- `validate-commit.sh`: review commit content and obvious violations before committing
- `validate-push.sh`: pause before risky push actions
- `validate-assets.sh`: inspect asset naming and metadata after asset changes
- `detect-gaps.sh`: use at session start for project hygiene
- `session-start.sh` / `session-stop.sh`: use as prompts for startup and wrap-up summaries

## When To Use This Skill

- before code review or design review
- before milestone or release checklists
- before claiming a migrated CCGS workflow is complete
- when a task spans multiple disciplines and needs a manual gate
- when you want the closest Codex equivalent to the original template's guardrails
