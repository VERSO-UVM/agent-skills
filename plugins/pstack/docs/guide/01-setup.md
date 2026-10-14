# Set up pstack

In this page you install the plugin, optionally pick which models pstack uses, and run your first task.

## Install the plugin

Install from the `VERSO-UVM/agent-skills` marketplace. Install `verso-kit` from it too, since `/poteto-mode` calls skills that ship there.

- **Claude Code:** run `/plugin marketplace add VERSO-UVM/agent-skills`, then `/plugin install pstack@verso-agent-skills` and `/plugin install verso-kit@verso-agent-skills`.
- **Cursor:** add `VERSO-UVM/agent-skills` as a plugin source, then enable `pstack` and `verso-kit`.
- **Other agents** (Codex, Gemini CLI, Copilot, and others): run `npx skills add VERSO-UVM/agent-skills`, or copy `plugins/pstack/skills/` into your agent's skills directory.

## Pick your models (optional)

Every pstack role (code delegates, judgment, the review panels) runs on your chat's model by default, so you can skip this step.

To split work by model strength, name a model per role in your always-on instructions file (`AGENTS.md`, `CLAUDE.md`, or `.cursor/rules/`), using the role labels `/poteto-mode` uses: code delegates, judgment, arena runners, architect runners, interrogate reviewers, swarm workers. For a panel role, list several models, and one subagent runs per entry, so the list length sets the panel size. A role with no line keeps the chat's model. Model names differ by harness, so use the ones your harness accepts for subagents.

## Create a verification skill

Before your first real task, give agents a way to prove app behavior in your project. If the project has no `verify-*` skill or existing harness, run [`/create-verification-skill`](../../skills/create-verification-skill/SKILL.md).

It writes `<skills-dir>/verify-<app>/` (for example `.claude/skills/`, `.cursor/skills/`, or `.agents/skills/`), a project-local skill that teaches agents to drive your app the way a user does. It proves the skill works once before handing it over. You can run `/create-verification-skill` yourself any time. [Verify and ship](./06-verify-and-ship.md#create-a-project-verification-skill) covers it in depth.

If you're new to pstack, say yes. An agent that can check its own work keeps going until the check passes. An agent that can't hands every result back to you to check by hand. Of everything in this guide, the verification skill pays off the most.

After changing your always-on instructions, start a new chat so they load.

## Keep the cost in check

pstack spends extra tokens on subagents and review panels. That's the price of the rigor. To spend fewer:

- Name cheaper, faster models for the code roles in your always-on instructions. A strong model in the main chat with cheaper, faster models in the code roles is a good split.
- Remove a role's model line so it runs on the chat's own model.
- Shorten a panel list. Each entry runs one subagent.
- Save `/poteto-mode` for work that needs rigor. A small, obvious edit doesn't.

## Run your first task

Pick something real but small, and describe it the way you'd describe it to a colleague:

```text
/poteto-mode add a --json flag to this command. text output stays byte-identical. verify both.
```

Watch the todo list. Its first items are the matched playbook's steps copied in, the Feature playbook for this prompt. If `/poteto-mode` skips a step, the step stays in the list with `skip: <reason>`, so you can see what it chose not to do.

From here you can type normal follow-ups. To keep `/poteto-mode` on for the whole chat, use your harness's way of pinning a skill if it has one. In Cursor, pick it from the `/` menu with Option+Enter (Mac) or Alt+Enter (Windows) to make it a [Custom Mode](https://cursor.com/docs/skills). Otherwise, re-invoke it at the start of each new task. A skill attached to one message fades as the chat moves on.

Next: [Route work through `/poteto-mode`](./02-poteto-mode.md).
