# academic-oss

> Moved from [VERSO-UVM/academic-open-source-helper](https://github.com/VERSO-UVM/academic-open-source-helper), adapted to be harness-neutral. See UPSTREAM.md at repo root.

Skills for taking an academic research repository from closed to open source, following research-software standards: [CITATION.cff](https://citation-file-format.github.io/), [codemeta](https://codemeta.github.io/), [FAIR](https://www.go-fair.org/fair-principles/), [OSI licenses](https://opensource.org/licenses), and [Zenodo](https://zenodo.org/) for DOI minting.

| Skill | What it does |
|:--|:--|
| [`secrets-scan`](skills/secrets-scan/SKILL.md) | Safety gate. Scans the working tree and git history for secrets and PII. |
| [`assess-readiness`](skills/assess-readiness/SKILL.md) | Scorecard across safety, legal, academic metadata, reproducibility, documentation, and hygiene. |
| [`citation-check`](skills/citation-check/SKILL.md) | Verifies DOIs resolve, validates or drafts `CITATION.cff` and `codemeta.json`, checks Zenodo readiness. |
| [`readme-gen`](skills/readme-gen/SKILL.md) | Drafts a research-tuned README (data provenance, reproducibility, citation, funding). |
| [`open-source-plan`](skills/open-source-plan/SKILL.md) | Synthesizes findings into a phased migration checklist that surfaces decisions instead of making them. |

## Install

- **Claude Code:** `/plugin marketplace add VERSO-UVM/agent-skills`, then `/plugin install academic-oss@verso-agent-skills`.
- **Cursor:** add `VERSO-UVM/agent-skills` as a plugin source, then enable `academic-oss`.
- **Other agents (Codex, Gemini CLI, Copilot, …):** `npx skills add VERSO-UVM/agent-skills`, or copy `plugins/academic-oss/skills/` into your agent's skills directory.

## Recommended order

1. `secrets-scan` first, always. CRITICAL findings block everything else; do not tell the researcher to proceed until they are resolved.
2. `assess-readiness` for the full picture.
3. `citation-check` to verify and generate citation metadata.
4. `readme-gen` to draft the README (optional).
5. `open-source-plan` for the phased checklist.

Each skill takes a path to the repository (default: the current directory) and can run on its own.

## Philosophy

**Issues-first, researcher-as-author.** These skills never silently change the scholarly record. CRITICAL findings (secrets, PII, dead DOIs) are reported with exact remediation steps; the researcher acts. Generated files (`CITATION.cff`, README drafts) are marked as drafts for human review.

**Limits.** The scans are run by the agent with `grep`, `git`, and, when installed, `trufflehog` or `detect-secrets`. They are not a guarantee. Install a dedicated secrets scanner for final verification before making a repository public.
