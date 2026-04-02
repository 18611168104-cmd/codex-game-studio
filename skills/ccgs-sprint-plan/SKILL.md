---
name: ccgs-sprint-plan
description: "Use when the user wants the Claude Code Game Studios \"sprint-plan\" workflow in Codex. Generates a new sprint plan or updates an existing one based on the current milestone, completed work, and available capacity. Pulls context from production documents and design backlogs."
---

# CCGS Sprint Plan

Codex adaptation of the Claude Code Game Studios `sprint-plan` workflow.

## Codex Translation Layer

- Original slash command: `/sprint-plan`
- Codex skill name: `ccgs-sprint-plan`
- Shared imported references live under: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo`
- When the original workflow refers to Claude-only tools or `AskUserQuestion`, use Codex equivalents: `shell_command`, `apply_patch`, `web`, and direct concise questions to the user.
- Imported `.claude/agents`, `.claude/rules`, and `.claude/hooks` are reference material only. Use `ccgs-agent-orchestration` and `ccgs-quality-gates` for Codex-usable behavior.

## Imported Workflow

When this skill is invoked:

1. **Read the current milestone** from `production/milestones/`.

2. **Read the previous sprint** (if any) from `production/sprints/` to
   understand velocity and carryover.

3. **Scan design documents** in `design/gdd/` for features tagged as ready
   for implementation.

4. **Check the risk register** at `production/risk-register/`.

For `new`:

5. **Generate a sprint plan** following this format:

```markdown
# Sprint [N] -- [Start Date] to [End Date]

## Sprint Goal
[One sentence describing what this sprint achieves toward the milestone]

## Capacity
- Total days: [X]
- Buffer (20%): [Y days reserved for unplanned work]
- Available: [Z days]

## Tasks

### Must Have (Critical Path)
| ID | Task | Agent/Owner | Est. Days | Dependencies | Acceptance Criteria |
|----|------|-------------|-----------|-------------|-------------------|

### Should Have
| ID | Task | Agent/Owner | Est. Days | Dependencies | Acceptance Criteria |
|----|------|-------------|-----------|-------------|-------------------|

### Nice to Have
| ID | Task | Agent/Owner | Est. Days | Dependencies | Acceptance Criteria |
|----|------|-------------|-----------|-------------|-------------------|

## Carryover from Previous Sprint
| Task | Reason | New Estimate |
|------|--------|-------------|

## Risks
| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|

## Dependencies on External Factors
- [List any external dependencies]

## Definition of Done for this Sprint
- [ ] All Must Have tasks completed
- [ ] All tasks pass acceptance criteria
- [ ] No S1 or S2 bugs in delivered features
- [ ] Design documents updated for any deviations
- [ ] Code reviewed and merged
```

For `status`:

5. **Generate a status report**:

```markdown
# Sprint [N] Status -- [Date]

## Progress: [X/Y tasks complete] ([Z%])

### Completed
| Task | Completed By | Notes |
|------|-------------|-------|

### In Progress
| Task | Owner | % Done | Blockers |
|------|-------|--------|----------|

### Not Started
| Task | Owner | At Risk? | Notes |
|------|-------|----------|-------|

### Blocked
| Task | Blocker | Owner of Blocker | ETA |
|------|---------|-----------------|-----|

## Burndown Assessment
[On track / Behind / Ahead]
[If behind: What is being cut or deferred]

## Emerging Risks
- [Any new risks identified this sprint]
```

### Agent Consultation

For comprehensive sprint planning, consider consulting:
- `producer` agent for capacity planning, risk assessment, and cross-department coordination
- `game-designer` agent for feature prioritization and design readiness assessment
