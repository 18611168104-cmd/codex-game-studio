---
name: ccgs-bug-report
description: "Use when the user wants the Claude Code Game Studios \"bug-report\" workflow in Codex. Creates a structured bug report from a description, or analyzes code to identify potential bugs. Ensures every bug report has full reproduction steps, severity assessment, and context."
---

# CCGS Bug Report

Codex adaptation of the Claude Code Game Studios `bug-report` workflow.

## Codex Translation Layer

- Original slash command: `/bug-report`
- Codex skill name: `ccgs-bug-report`
- Shared imported references live under: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo`
- When the original workflow refers to Claude-only tools or `AskUserQuestion`, use Codex equivalents: `shell_command`, `apply_patch`, `web`, and direct concise questions to the user.
- Imported `.claude/agents`, `.claude/rules`, and `.claude/hooks` are reference material only. Use `ccgs-agent-orchestration` and `ccgs-quality-gates` for Codex-usable behavior.

## Imported Workflow

When invoked with a description:

1. **Parse the description** for key information.

2. **Search the codebase** for related files using Grep/Glob to add context.

3. **Generate the bug report**:

```markdown
# Bug Report

## Summary
**Title**: [Concise, descriptive title]
**ID**: BUG-[NNNN]
**Severity**: [S1-Critical / S2-Major / S3-Minor / S4-Trivial]
**Priority**: [P1-Immediate / P2-Next Sprint / P3-Backlog / P4-Wishlist]
**Status**: Open
**Reported**: [Date]
**Reporter**: [Name]

## Classification
- **Category**: [Gameplay / UI / Audio / Visual / Performance / Crash / Network]
- **System**: [Which game system is affected]
- **Frequency**: [Always / Often (>50%) / Sometimes (10-50%) / Rare (<10%)]
- **Regression**: [Yes/No/Unknown -- was this working before?]

## Environment
- **Build**: [Version or commit hash]
- **Platform**: [OS, hardware if relevant]
- **Scene/Level**: [Where in the game]
- **Game State**: [Relevant state -- inventory, quest progress, etc.]

## Reproduction Steps
**Preconditions**: [Required state before starting]

1. [Exact step 1]
2. [Exact step 2]
3. [Exact step 3]

**Expected Result**: [What should happen]
**Actual Result**: [What actually happens]

## Technical Context
- **Likely affected files**: [List of files based on codebase search]
- **Related systems**: [What other systems might be involved]
- **Possible root cause**: [If identifiable from the description]

## Evidence
- **Logs**: [Relevant log output if available]
- **Visual**: [Description of visual evidence]

## Related Issues
- [Links to related bugs or design documents]

## Notes
[Any additional context or observations]
```

When invoked with `analyze`:

1. **Read the target file(s)**.
2. **Identify potential bugs**: null references, off-by-one errors, race
   conditions, unhandled edge cases, resource leaks, incorrect state
   transitions.
3. **For each potential bug**, generate a bug report with the likely trigger
   scenario and recommended fix.
