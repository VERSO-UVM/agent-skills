# ORCA students and the VERSO agent skills

Status: proposal, not started. Written 2026-10-15.

This note covers how ORCA student teams should use the skills in this repo, what they cost, where they conflict, and how they work outside Claude Code.

## Recommendation

Don't make `/poteto-mode` the default for ORCA students. Give students skills they call by name (`teach`, `how`, `why`, `unslop`, `technical-writing`, plus `verso-kit` and `academic-oss`). Keep poteto-mode for mentors, staff, and advanced students on large projects.

Students learn by making design choices. Poteto-mode is built to make those choices for them and to spend tokens on subagents to do it.

## What the skills cost

Numbers below were measured from `plugins/` on 2026-10-15 unless marked as an estimate.

**Idle cost.** All 52 pstack skills set `disable-model-invocation: true`, so none load until someone calls them by name. The 13 verso-kit skills and 5 academic-oss skills are model-invocable. Their descriptions sit in context every session, about 3,400 characters together. Estimate: under 1,000 tokens per turn.

**Poteto-mode once invoked.**

- `poteto-mode/SKILL.md` is 21 KB. Estimate: about 5,000 tokens, loaded once per conversation.
- All playbooks total 91 KB. A task reads one.
- The routed skills (`how`, `architect`, `swarm`, `interrogate`, `unslop`) and all `principle-*` leaves total 55 KB.
- Subagents multiply the cost. Every `poteto-agent` reads `poteto-mode/SKILL.md` in full first. `how` spawns explorers and explainers. `interrogate` spawns one reviewer per model. `swarm` spawns N workers. Any code crossing a function boundary triggers `architect` parallel design exploration.

Guess, not measured: a small bug fix under poteto-mode costs several times a plain session. To measure it, run the same small task with and without poteto-mode and compare `/cost`.

## Conflicts and gaps

1. **Autonomy versus confirm-first.** Poteto-mode says external actions such as team chat and ticket updates proceed without asking. Claude Code's default is to confirm outward-facing actions. Students need the confirm-first rule.
2. **Never block on the human versus learning.** Poteto-mode settles "which approach" forks by experiment instead of asking. For a student, that removes the decision they are supposed to learn from.
3. **Laziness and Subtract Before You Add versus Exhaust the Design Space, `architect`, and `swarm`.** The triggers separate them on paper. The `architect` trigger is broad enough to fire on small student changes.
4. **Missing dependencies.** Poteto-mode routes to `deslop`, `control-ui`, and `control-cli` from verso-kit. With pstack installed alone, those triggers point at nothing. The "broken skill mid-task, fix it in its own PR" rule could then push an agent to open PRs against this repo.
5. **`unslop` versus `technical-writing`.** Unslop rule 13 bans parentheses. `technical-writing` line 86 allows them when they hold a full grammatical unit.
6. **`no-comments` and Comment Sicko versus teaching.** `no-comments` defers to a persona described as "deranged" that hates comments. Comments that explain *why* help students, and the tone may not suit them.
7. **`interrogate` assumes several model families.** In Claude Code every reviewer is Claude, so the diversity signal is weaker. The skill handles this and says so.

## Options

| Option | Cost | Learning value | Risk |
|:--|:--|:--|:--|
| Poteto-mode for everyone | Highest | Low, the agent decides | External actions, PRs against this repo |
| Called-by-name skills only | Low | High, `teach` explains without changing code | Low |
| Forked student-mode skill | Medium | High if designed for it | A second copy to maintain |

Chosen direction: called-by-name now. Revisit a student-mode fork if students outgrow it.

## Does called-by-name remove poteto-mode?

No. It stays installed as a manual-only pstack skill and costs nothing until someone types `/poteto-mode`.

To take it away entirely, don't distribute pstack to students. Ship a separate `student` plugin with only the skills they need.

One dependency to fix when doing that. `how` and `why` (line 11 in each) cite "the Subagents section of the **poteto-mode** skill" for picking subagent reasoning level. `teach` runs both. Copy that paragraph into the student plugin or drop the reference.

## Using the skills outside Claude

`AGENTS.md` requires every skill to work in Claude Code, Cursor, Codex, Gemini CLI, Copilot, and others. Skills are plain `SKILL.md` folders in the Agent Skills format. Install with `npx skills add VERSO-UVM/agent-skills`.

**ChatGPT.**

- Codex (CLI, IDE extension, and inside ChatGPT) reads Agent Skills folders. `AGENTS.md` lists `~/.codex/skills/` as a skill location. Use this path.
- Plain ChatGPT chat can't read a repo. Its current skill support was not checked. Fallback is to paste a SKILL.md or attach it to a custom GPT or project. This works for prose skills (`unslop`, `teach`, `technical-writing`) and fails for skills that spawn subagents or read the codebase (`how`, `why`, `swarm`, poteto-mode).

**Open-source agents.** Agents that read the Agent Skills format behave like Codex. OpenCode and Goose are believed to, not verified. For any other agent, reference the SKILL.md files from its instructions file (`AGENTS.md`, a rules file, or a system prompt).

**Differences between harnesses.**

- `disable-model-invocation` started as a Claude Code field. This repo treats it as portable, but support in each harness was not checked. Test it by asking for something that matches a skill's description without naming the skill, and see whether it loads.
- Skills that assume subagents fall back to one thread where the harness can't spawn them. They run slower with less cross-checking.
- In Codex or a multi-model open-source agent, `interrogate` can mix Claude and non-Claude reviewers, which is how it was designed.
- Claude Code reads `CLAUDE.md`. Codex and most open-source agents read `AGENTS.md`. This repo's `CLAUDE.md` is just `@AGENTS.md`, and student repos can do the same so one file serves every harness.

## Next steps

1. Add a `student` plugin to `plugins/` with `teach`, `how`, `why`, `unslop`, and `technical-writing`. Fix the poteto-mode references in `how` and `why`.
2. Write a shared `AGENTS.md` block for student repos. Pause before any external action. Present options and let the student choose. Explain every change. Name model roles to cap subagent cost if a student turns on poteto-mode.
3. Add a project `.claude/settings.json` template for student repos that enables the student plugin, `verso-kit`, and `academic-oss`. The README has the base template.
4. Fix the verso-kit gap. Install verso-kit with pstack, or make poteto-mode's verso-kit triggers conditional on it being present.
5. Decide where the student rules live relative to `agentic-team`, which already has a Student mode for ORCA interns (its README line 6).
6. Test `disable-model-invocation` and skill loading in Codex and one open-source agent the students will use.
7. Measure the poteto-mode cost on one small task with `/cost` before deciding about staff use.

## Open decisions

- Do students get poteto-mode at all, or only staff?
- Is the student plugin part of this repo or a separate marketplace entry?
- Which agents will ORCA students actually use?
