# VERSO agent skills

Shared skills for software and agentic coding work at VERSO. They follow the open [Agent Skills](https://agentskills.io) format (`SKILL.md` folders), so they work in Claude Code, Cursor, Codex, Gemini CLI, and other harnesses that read it.

| Plugin | What it does |
|:--|:--|
| [`pstack`](plugins/pstack/) | `/poteto-mode`, a rigorous working style: plan before code, verify before "done", parallel subagents. Includes ~50 skills such as `sharpen`, `how`, `why`, `blast-radius`, `interrogate`, `unslop`, `technical-writing`, `teach`, and the `principle-*` engineering principles. |
| [`verso-kit`](plugins/verso-kit/) | Team workflow: `new-branch-and-pr`, `review-and-ship`, `make-pr-easy-to-review`, `get-pr-comments`, `fix-ci`, `loop-on-ci`, `fix-merge-conflicts`, `verify-this`, `deslop`, `control-cli`, `control-ui`, `what-did-i-get-done`, `weekly-review`. |

## Install

Install once per machine. You don't need to clone this repo.

**Claude Code**

```
/plugin marketplace add VERSO-UVM/agent-skills
/plugin install pstack@verso-agent-skills
/plugin install verso-kit@verso-agent-skills
```

Update later with `/plugin marketplace update verso-agent-skills`.

**Cursor**: add `VERSO-UVM/agent-skills` as a plugin marketplace in Cursor's plugin settings, then install `pstack` and `verso-kit`.

**Codex, Gemini CLI, and other agents**: use the cross-agent [skills CLI](https://github.com/vercel-labs/skills), which knows where each agent looks for skills:

```sh
npx skills add VERSO-UVM/agent-skills          # into the current project
npx skills add VERSO-UVM/agent-skills -g       # for your user, all projects
```

Or copy the folders under `plugins/*/skills/` into your agent's skills directory.

## Suggest these skills in a team repo (Claude Code)

Commit this as `.claude/settings.json` in a project. Collaborators who open it in Claude Code are prompted to install the plugins; nothing installs without their OK.

```json
{
  "extraKnownMarketplaces": {
    "verso-agent-skills": { "source": { "source": "github", "repo": "VERSO-UVM/agent-skills" } }
  },
  "enabledPlugins": {
    "pstack@verso-agent-skills": true,
    "verso-kit@verso-agent-skills": true
  }
}
```

## Contributing

Read [`AGENTS.md`](AGENTS.md) for how to write harness-neutral skills, and run `scripts/check.sh` before committing. [`UPSTREAM.md`](UPSTREAM.md) explains where the skills came from and how to pull upstream changes.

## License

MIT (see [`LICENSE`](LICENSE)). Most skills are adapted from [cursor/plugins](https://github.com/cursor/plugins) (MIT, © Cursor); see each plugin's `LICENSE`.
