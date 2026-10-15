# Working in agent-skills

This repo is a harness-agnostic skill library. Skills are plain `SKILL.md` folders under `plugins/<plugin>/skills/`. The per-harness manifests (`.claude-plugin/`, `.cursor-plugin/`, `plugin.json`) only point at those folders; they never hold skill content.

## Rules for skill text

Write every skill so any coding agent can follow it: Claude Code, Cursor, Codex, Gemini CLI, Copilot, or the next one.

- Name capabilities, not one harness's tool names. Say "ask the user", "spawn a subagent", "run in the background".
- When a harness-specific path or tool genuinely matters, list the common harnesses side by side instead of picking one.
- Keep frontmatter to the portable fields: `name`, `description`, and `disable-model-invocation` where the skill should only run when invoked by name.
- Run `scripts/check.sh` before committing. It validates frontmatter and flags harness-specific wording.

## Porting glossary

Use these substitutions when bringing in skills written for a single harness (most upstream skills here came from Cursor).

| Harness-specific | Neutral |
|:--|:--|
| `AskQuestion` | ask the user (use your harness's structured-question tool if it has one) |
| `Task` subagent, `Task` spawn | subagent, spawn a subagent |
| `generalPurpose` subagent | a general-purpose subagent |
| `~/.cursor/plugins/` lookups | the harness's plugin or skill directories: `~/.claude/plugins/`, `~/.cursor/plugins/`, `~/.agents/skills/`, `~/.codex/skills/` |
| `.mdc` rules, `~/.cursor/rules/`, always-applied rule | the always-on instructions file: `AGENTS.md`, `CLAUDE.md`, or `.cursor/rules/` |
| Bugbot | automated PR review bots (Bugbot, Copilot review, CodeRabbit, and similar) |
| Cursor cloud or background agents | remote agents if your harness has them, otherwise local subagents in separate worktrees |
| `cursor-team-kit` | `verso-kit` (this repo) |
| Cursor model slugs, `setup-pstack` model roles | the parent chat's model, unless the user's always-on instructions name a model for that role |
| `is_background`, `model: fast` agent frontmatter | drop |

Keep attribution to upstream authors. Port the meaning, not just the words, and keep edits minimal so upstream changes stay easy to merge (see `UPSTREAM.md`).

## AI use and compliance

This repo follows UVM's [AI guidance](https://www.uvm.edu/ai/university-wide-ai-guidance) and [approved AI tools list](https://www.uvm.edu/ai/supported-and-approved-ai-tools). You are responsible for anything an AI tool produces for you here.

**Data classification:** Public (Low Risk). This repo is public on GitHub, so put nothing here you would not post publicly. Levels are defined in the UVM [Data Classification Matrix](https://www.uvm.edu/d10-files/documents/2025-07/Data_Risk_Classification_Matrix.pdf).

**Approved tools and the data they may see:**

| Tool | Data allowed |
|:--|:--|
| Claude, UVM license, signed in with your UVM account | Low to Moderate Risk. High Risk only after consulting iso@uvm.edu. Do not use a personal Claude account. |
| Microsoft Copilot, signed in with your NetID | Low to High Risk |
| Tools without a UVM license (personal ChatGPT, Claude, Gemini, and similar) | Public data only. Any other use needs UVM Contract Review. |

**Agent permissions:** Agents may propose edits. A human reviews each change before it is committed; after that review, the agent or the human may commit. All changes go through git, so they are logged and can be undone.

**Verification:** Check AI output before you act on it. Every claim an AI adds must cite a source in the document's Evidence section. If a claim can't be verified, remove it or mark it as uncertain.

**Disclosure:** If AI helped with a commit, the commit message says so.

**Downstream use:** Never move content into a tool approved for a lower risk level. For example, text from a VERSO staff Microsoft 365 Copilot digest must not go into a personal AI account or into this public repo.

**When unsure:** Stop and ask Kendall about data or tools. Send policy questions to iso@uvm.edu.

### Evidence

Retrieved 2026-10-15.

- [UVM university-wide AI guidance](https://www.uvm.edu/ai/university-wide-ai-guidance): users are responsible for outputs, review before acting, disclosure, downstream use, safeguards for autonomous systems.
- [UVM supported and approved AI tools](https://www.uvm.edu/ai/supported-and-approved-ai-tools): tools, risk levels, personal Claude accounts, Contract Review, iso@uvm.edu.
- [UVM Data Classification Matrix](https://www.uvm.edu/d10-files/documents/2025-07/Data_Risk_Classification_Matrix.pdf): data risk levels.
