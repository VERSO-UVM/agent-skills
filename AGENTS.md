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
