---
name: ccgs-onboard
description: "Use when the user wants the Claude Code Game Studios \"onboard\" workflow in Codex. Generates a contextual onboarding document for a new contributor or agent joining the project. Summarizes project state, architecture, conventions, and current priorities relevant to the specified role or area."
---

# CCGS Onboard

Codex adaptation of the Claude Code Game Studios `onboard` workflow.

## Codex Translation Layer

- Original slash command: `/onboard`
- Codex skill name: `ccgs-onboard`
- Shared imported references live under: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo`
- When the original workflow refers to Claude-only tools or `AskUserQuestion`, use Codex equivalents: `shell_command`, `apply_patch`, `web`, and direct concise questions to the user.
- Imported `.claude/agents`, `.claude/rules`, and `.claude/hooks` are reference material only. Use `ccgs-agent-orchestration` and `ccgs-quality-gates` for Codex-usable behavior.

## Imported Workflow

When this skill is invoked:

1. **Read the CLAUDE.md** for project overview and standards.

2. **Read the relevant agent definition** from `.claude/agents/` if a specific
   role is specified.

3. **Scan the codebase** for the relevant area:
   - For programmers: scan `src/` for architecture, patterns, key files
   - For designers: scan `design/` for existing design documents
   - For narrative: scan `design/narrative/` for world-building and story docs
   - For QA: scan `tests/` for existing test coverage
   - For production: scan `production/` for current sprint and milestone

4. **Read recent changes** (git log if available) to understand current momentum.

5. **Generate the onboarding document**:

```markdown
# Onboarding: [Role/Area]

## Project Summary
[2-3 sentence summary of what this game is and its current state]

## Your Role
[What this role does on this project, key responsibilities, who you report to]

## Project Architecture
[Relevant architectural overview for this role]

### Key Directories
| Directory | Contents | Your Interaction |
|-----------|----------|-----------------|

### Key Files
| File | Purpose | Read Priority |
|------|---------|--------------|

## Current Standards and Conventions
[Summary of conventions relevant to this role from CLAUDE.md and agent definition]

## Current State of Your Area
[What has been built, what is in progress, what is planned next]

## Current Sprint Context
[What the team is working on now and what is expected of this role]

## Key Dependencies
[What other roles/systems this role interacts with most]

## Common Pitfalls
[Things that trip up new contributors in this area]

## First Tasks
[Suggested first tasks to get oriented and productive]

1. [Read these documents first]
2. [Review this code/content]
3. [Start with this small task]

## Questions to Ask
[Questions the new contributor should ask to get fully oriented]
```
