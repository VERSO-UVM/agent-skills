# Upstream

Most skills here are adapted from [cursor/plugins](https://github.com/cursor/plugins) (MIT).

| Plugin | Upstream | Upstream commit |
|:--|:--|:--|
| `plugins/pstack` | `pstack/` (v0.15.24, Lauren Tan) | `1e5c90a4b6f249917bd21fe361b3a2a7deb741b8` |
| `plugins/verso-kit` | `cursor-team-kit/skills/` (Eric Zakariasson) | `1e5c90a4b6f249917bd21fe361b3a2a7deb741b8` |
| `plugins/academic-oss` | [VERSO-UVM/academic-open-source-helper](https://github.com/VERSO-UVM/academic-open-source-helper) `skills/` (VERSO / ORCA) | `49c7eca0678342f477763704701b0fe612252364` |

## What changed from upstream

- Cursor-specific instructions rewritten to harness-neutral wording, per the glossary in `AGENTS.md`.
- Removed from pstack: `skills/setup-pstack` (wrote Cursor model rules) and `automations/benny` (Cursor Automations). Model roles now default to the parent chat's model.
- verso-kit keeps 13 of cursor-team-kit's skills: `new-branch-and-pr`, `review-and-ship`, `make-pr-easy-to-review`, `get-pr-comments`, `fix-ci`, `loop-on-ci`, `fix-merge-conflicts`, `verify-this`, `what-did-i-get-done`, `weekly-review`, `deslop`, `control-cli`, `control-ui`.
- Added manifests for Claude Code, Cursor, and the agent-plugins.org schema.
- academic-oss: frontmatter cut to `name`/`description` (dropped Claude-specific `context: fork`, `agent`, `allowed-tools`, `argument-hint`, plus `compatibility`, `license`, `metadata`); `$ARGUMENTS` replaced by "the path the user gave" with `$REPO_PATH` defined; `/skill` slash references made neutral; root `SKILL.md`, `catalog.json`, `GEMINI.md`, `gemini-extension.json`, and Copilot instructions folded into the plugin README. Content fixes: trufflehog no longer uses `--only-verified`, updated OpenAI/Anthropic key patterns, softened the GPL licensing guidance, noted the PyYAML dependency. This plugin is now the canonical home for these skills; the original repo keeps the MCP server spec.

## Pulling upstream changes

```sh
cd ../plugins && git pull
git diff 1e5c90a..HEAD --stat -- pstack cursor-team-kit
```

Apply the relevant changes by hand (or ask an agent to, pointing it at `AGENTS.md`), run `scripts/check.sh`, then update the commit hash above.
