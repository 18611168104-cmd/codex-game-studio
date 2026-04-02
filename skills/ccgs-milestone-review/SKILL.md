---
name: ccgs-milestone-review
description: "Use when the user wants the Claude Code Game Studios \"milestone-review\" workflow in Codex. Generates a comprehensive milestone progress review including feature completeness, quality metrics, risk assessment, and go/no-go recommendation. Use at milestone checkpoints or when evaluating readiness for a milestone deadline."
---

# CCGS Milestone Review

Codex adaptation of the Claude Code Game Studios `milestone-review` workflow.

## Codex Translation Layer

- Original slash command: `/milestone-review`
- Codex skill name: `ccgs-milestone-review`
- Shared imported references live under: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo`
- When the original workflow refers to Claude-only tools or `AskUserQuestion`, use Codex equivalents: `shell_command`, `apply_patch`, `web`, and direct concise questions to the user.
- Imported `.claude/agents`, `.claude/rules`, and `.claude/hooks` are reference material only. Use `ccgs-agent-orchestration` and `ccgs-quality-gates` for Codex-usable behavior.

## Imported Workflow

When this skill is invoked:

1. **Read the milestone definition** from `production/milestones/`.

2. **Read all sprint reports** for sprints within this milestone from
   `production/sprints/`.

3. **Scan the codebase** for TODO, FIXME, HACK markers that indicate
   incomplete work.

4. **Check the risk register** at `production/risk-register/`.

5. **Generate the milestone review**:

```markdown
# Milestone Review: [Milestone Name]

## Overview
- **Target Date**: [Date]
- **Current Date**: [Today]
- **Days Remaining**: [N]
- **Sprints Completed**: [X/Y]

## Feature Completeness

### Fully Complete
| Feature | Acceptance Criteria | Test Status |
|---------|-------------------|-------------|

### Partially Complete
| Feature | % Done | Remaining Work | Risk to Milestone |
|---------|--------|---------------|------------------|

### Not Started
| Feature | Priority | Can Cut? | Impact of Cutting |
|---------|----------|----------|------------------|

## Quality Metrics
- **Open S1 Bugs**: [N] -- [List]
- **Open S2 Bugs**: [N]
- **Open S3 Bugs**: [N]
- **Test Coverage**: [X%]
- **Performance**: [Within budget? Details]

## Code Health
- **TODO count**: [N across codebase]
- **FIXME count**: [N]
- **HACK count**: [N]
- **Technical debt items**: [List critical ones]

## Risk Assessment
| Risk | Status | Impact if Realized | Mitigation Status |
|------|--------|-------------------|------------------|

## Velocity Analysis
- **Planned vs Completed** (across all sprints): [X/Y tasks = Z%]
- **Trend**: [Improving / Stable / Declining]
- **Adjusted estimate for remaining work**: [Days needed at current velocity]

## Scope Recommendations
### Protect (Must ship with milestone)
- [Feature and why]

### At Risk (May need to cut or simplify)
- [Feature and risk]

### Cut Candidates (Can defer without compromising milestone)
- [Feature and impact of cutting]

## Go/No-Go Assessment

**Recommendation**: [GO / CONDITIONAL GO / NO-GO]

**Conditions** (if conditional):
- [Condition 1 that must be met]
- [Condition 2 that must be met]

**Rationale**: [Explanation of the recommendation]

## Action Items
| # | Action | Owner | Deadline |
|---|--------|-------|----------|
```
