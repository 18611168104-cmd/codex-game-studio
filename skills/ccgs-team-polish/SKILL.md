---
name: ccgs-team-polish
description: "Use when the user wants the Claude Code Game Studios \"team-polish\" workflow in Codex. Orchestrate the polish team: coordinates performance-analyst, technical-artist, sound-designer, and qa-tester to optimize, polish, and harden a feature or area for release quality."
---

# CCGS Team Polish

Codex adaptation of the Claude Code Game Studios `team-polish` workflow.

## Codex Translation Layer

- Original slash command: `/team-polish`
- Codex skill name: `ccgs-team-polish`
- Shared imported references live under: `C:\Users\18143\.codex\skills\ccgs-studio\references\repo`
- When the original workflow refers to Claude-only tools or `AskUserQuestion`, use Codex equivalents: `shell_command`, `apply_patch`, `web`, and direct concise questions to the user.
- Imported `.claude/agents`, `.claude/rules`, and `.claude/hooks` are reference material only. Use `ccgs-agent-orchestration` and `ccgs-quality-gates` for Codex-usable behavior.

## Imported Workflow

When this skill is invoked, orchestrate the polish team through a structured pipeline.

**Decision Points:** At each phase transition, use `ask the user directly with a concise plain-text question` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.

## Team Composition
- **performance-analyst** - Profiling, optimization, memory analysis, frame budget
- **technical-artist** - VFX polish, shader optimization, visual quality
- **sound-designer** - Audio polish, mixing, ambient layers, feedback sounds
- **qa-tester** - Edge case testing, regression testing, soak testing

## How to Delegate

Use the Task tool to spawn each team member as a subagent:
- `subagent_type: performance-analyst` - Profiling, optimization, memory analysis
- `subagent_type: technical-artist` - VFX polish, shader optimization, visual quality
- `subagent_type: sound-designer` - Audio polish, mixing, ambient layers
- `subagent_type: qa-tester` - Edge case testing, regression testing, soak testing

Always provide full context in each agent's prompt (target feature/area, performance budgets, known issues). Launch independent agents in parallel where the pipeline allows it (e.g., Phases 3 and 4 can run simultaneously).

## Pipeline

### Phase 1: Assessment
Delegate to **performance-analyst**:
- Profile the target feature/area using `ccgs-perf-profile`
- Identify performance bottlenecks and frame budget violations
- Measure memory usage and check for leaks
- Benchmark against target hardware specs
- Output: performance report with prioritized optimization list

### Phase 2: Optimization
Delegate to **performance-analyst** (with relevant programmers as needed):
- Fix performance hotspots identified in Phase 1
- Optimize draw calls, reduce overdraw
- Fix memory leaks and reduce allocation pressure
- Verify optimizations don't change gameplay behavior
- Output: optimized code with before/after metrics

### Phase 3: Visual Polish (parallel with Phase 2)
Delegate to **technical-artist**:
- Review VFX for quality and consistency with art bible
- Optimize particle systems and shader effects
- Add screen shake, camera effects, and visual juice where appropriate
- Ensure effects degrade gracefully on lower settings
- Output: polished visual effects

### Phase 4: Audio Polish (parallel with Phase 2)
Delegate to **sound-designer**:
- Review audio events for completeness (are any actions missing sound feedback?)
- Check audio mix levels - nothing too loud or too quiet relative to the mix
- Add ambient audio layers for atmosphere
- Verify audio plays correctly with spatial positioning
- Output: audio polish list and mixing notes

### Phase 5: Hardening
Delegate to **qa-tester**:
- Test all edge cases: boundary conditions, rapid inputs, unusual sequences
- Soak test: run the feature for extended periods checking for degradation
- Stress test: maximum entities, worst-case scenarios
- Regression test: verify polish changes haven't broken existing functionality
- Test on minimum spec hardware (if available)
- Output: test results with any remaining issues

### Phase 6: Sign-off
- Collect results from all team members
- Compare performance metrics against budgets
- Report: READY FOR RELEASE / NEEDS MORE WORK
- List any remaining issues with severity and recommendations

## Output
A summary report covering: performance before/after metrics, visual polish changes, audio polish changes, test results, and release readiness assessment.
