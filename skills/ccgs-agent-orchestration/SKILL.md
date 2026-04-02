---
name: ccgs-agent-orchestration
description: "Use when the user wants to apply the imported Claude Code Game Studios director/lead/specialist hierarchy in Codex, coordinate role-based game-development work, or explicitly asks for delegation or parallel studio-style agent work."
---

# CCGS Agent Orchestration

Use this skill to apply the imported Claude Code Game Studios role hierarchy in Codex.

Imported role profiles live at:
`C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\agents`

Coordination references live at:
- `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\docs\agent-roster.md`
- `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\docs\agent-coordination-map.md`
- `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\CLAUDE.md`

## Core Adaptation Rule

Codex cannot auto-load Claude `.claude/agents/*.md` files as native local agents.
Treat those files as reference prompts.

## How To Use In Codex

### 1. No explicit delegation request from the user

Do not spawn subagents.
Instead, emulate the selected role locally:
- read the relevant imported role file
- adopt its domain boundaries and quality bar
- keep execution in the main thread

### 2. User explicitly asks for delegation, sub-agents, or parallel work

Then you may use Codex subagents.
When doing so:
- choose the minimum set of imported roles needed
- give each spawned agent a disjoint ownership area
- pass the relevant role profile path from `C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\agents`
- keep one coordinator role in the main thread
- do not ask subagents to enforce Claude-only hooks; translate those checks locally

## Recommended Role Mapping

- Studio-wide direction: `creative-director`, `technical-director`, `producer`
- Feature decomposition: `game-designer`, `lead-programmer`, `qa-lead`
- Engine specialization: `godot-specialist`, `unity-specialist`, `unreal-specialist`
- Execution specialists: gameplay / engine / UI / tools / economy / narrative / audio / QA roles from the imported roster

## Minimal Prompt Pattern For Spawned Codex Agents

Use a prompt shaped like this:

```text
You are filling the imported Claude Code Game Studios role `<role-name>`.
Read this reference first: C:\Users\18143\.codex\skills\ccgs-studio\references\repo\.claude\agents\<role-name>.md
Own only: <specific files or responsibility>
You are not alone in the codebase. Do not revert other edits.
Return concrete changes, decisions, and any unresolved risks.
```

## Coordination Rules

- Keep vertical delegation simple: director -> lead -> specialist
- Use one owner per write scope
- Escalate cross-domain conflicts back to the main thread
- Treat imported role prompts as guidance, not law, when they conflict with Codex system or developer rules
