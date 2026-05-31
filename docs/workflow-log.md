# CharisMaster — multi-terminal workflow log

> Per-terminal record of what each Claude Code session did during the
> hackathon. Built as a retro + Ship Me input + future-Jenny reference.
> One section per terminal. Each terminal owns its own section and
> appends to this file when it's done with the active build.

Created 2026-05-31 ~14:35 PT by Terminal C, post-submission.

---

## Overview

**Hackathon:** GDG Stanford × Red Bull Basement, San Francisco, 2026-05-31. Hard
submission cutoff 2:30 PM PT. Solo founder Jenny Ruan coordinating four parallel
Claude Code terminals (A, B, C, D — D was killed mid-build) plus one zsh
terminal, all writing into the same repo `~/code/experiments/charismaster/`,
sync'd via `STATUS.md` heartbeats + `.claude/sync-hook.sh` running on every
`UserPromptSubmit`.

**Build target shifted twice mid-flight:**

1. ~11:47 — original plan was hand-rolled Next.js + Gemini SDK + manual Cloud
   Run deploy. Terminal A scaffolded `package.json`, `lib/gemini.ts`, etc.
2. ~12:14 — pivot 1: Jenny confirmed hackathon requires building through
   **Google AI Studio Build mode**. All hand-rolled scaffold thrown out; A
   refocused on writing the AI Studio prompt.
3. ~14:00 — pivot 2: after Studio rendered v1 (3-mode app with per-mode forms +
   `/report/[id]`), Jenny pasted a refactor brief that introduced a **Project
   entity** with multimodal context + AI-generated tasks, mode workspaces with
   parallel multi-output cards, per-card refine + version dropdown + screen-size
   toggle + share.

**Product framework also evolved fast:**

1. ~12:25 — locked 2-mode framework: 🎓 Coach (how-to) + 🎯 Cheatsheet (script).
2. ~12:42 — rename + features: 🎓 Coach Me + 🎯 Save Me, both graphical, screen-
   size toggle, iterative refinement.
3. ~13:05 — added 🚀 Ship Me as third mode. Recursive money shot: CharisMaster
   writes CharisMaster's own launch page in the demo.

**Final 3-mode product:** Coach me, save me, ship me. Land your message either
way.

**Coordination doctrine:** push direct to `main` (no branches, no PRs); print
`git diff origin/main --stat` before push, don't pause for confirmation; append
one STATUS.md heartbeat line after every meaningful action so other terminals
see it on next sync; ownership map in CLAUDE.md §4 to prevent file collisions.

---

## Terminal A — AI Studio prompt + Gemini wiring

**Owner:** [Terminal A to fill in this section]

**Joined sync:** 11:47 PT
**Original slice:** scaffold + Gemini integration (Next.js skeleton, `lib/gemini.ts`, `lib/schema.ts`, `lib/reference-corpus.ts`, `/api/analyze`, Dockerfile, `.env.example`)
**Post-pivot slice:** `docs/ai-studio-prompt.md` (the canonical paste-into-Studio prompt) + `docs/ai-studio-build-rules.md`

### Key commits

- [Terminal A: list your commit short-shas and one-line descriptions]

### Key decisions

- [Terminal A: 3-5 bullets on the architectural decisions you made and why]

### What worked

- [Terminal A: what went well]

### What didn't

- [Terminal A: what you'd do differently next time]

### Lessons for future Jenny

- [Terminal A: 2-3 transferable lessons]

---

## Terminal B — Deploy + smoke + post-pivot helpers

**Owner:** [Terminal B to fill in this section]

**Joined sync:** 11:58 PT
**Original slice:** `scripts/deploy.sh`, `scripts/smoke.sh`, `scripts/setup.sh`
**Post-pivot slice (if claimed):** `docs/few-shot-examples.md`, `docs/ship-me-demo-input.md`, `scripts/smoke.sh`

### Key commits

- [Terminal B: list your commit short-shas and one-line descriptions]

### Key decisions

- [Terminal B: what you owned, what you cut after the AI Studio pivot]

### What worked

- [Terminal B: what went well]

### What didn't

- [Terminal B: what you'd do differently next time]

### Lessons for future Jenny

- [Terminal B: 2-3 transferable lessons]

---

## Terminal C — Output spec + submission docs + recording playbook

**Owner:** Terminal C (Opus 4.7 1M context)
**Joined sync:** 12:05 PT (originally tagged B, retagged C per Jenny at 12:10)
**Final slice:** `docs/output-spec.md`, `docs/one-pager.md`, `docs/demo-script.md`, `docs/team-intro-script.md`, README rewrite, `docs/submission-form-answers.md` (took over from killed Terminal D), `docs/demo-prep.md`, `docs/demo-script-v2-draft.md` (v2 sidecar), `docs/project-context-paste.md` (Project workspace paste-ready blob), inline strategic input on idea selection + 5-axis judging optimization + product framing locks + Ship Me as recursive demo, on-the-fly drafts of the one-pager-field form answer.

### Key commits

- `3b71c61` — Claim Terminal C slice (CLAUDE.md §4 + STATUS.md)
- `dc5d730` — LOCK 2-mode product framework (Coach + Cheatsheet)
- `47d5102` — 3-mode product spec + all submission docs (`docs/output-spec.md`, `docs/one-pager.md`, `docs/demo-script.md`, `docs/team-intro-script.md`)
- `7a17ce8` — Post-pivot C slice: README rewrite for 3-mode framing + `docs/submission-form-answers.md` (rebuilt from D's stale 2-mode draft) + `docs/demo-prep.md` (tab-by-tab recording playbook + escalation order + social distribution copy)
- `b76f4bc` — `docs/demo-script-v2-draft.md` sidecar for the v2 Project + parallel-cards architecture (v1 demo script left intact as fallback)
- `72c7250` — `docs/project-context-paste.md` (paste-ready blob for the `0531_hackathon` Project workspace's textarea)

### Key decisions

- **Hybrid Path C (~11:55):** when Jenny pivoted from CharisMaster (performance coach) to a generic how-to one-pager generator, I pushed back honestly and proposed a third path: keep CharisMaster's brand + wedge but pivot the OUTPUT from "side-by-side report" to "personalized how-to one-pager." Strictly beat both alternatives on the 5 judging axes (table matrix in conversation). Jenny accepted; this became the locked direction.
- **Both modes graphical, not just one (~12:42):** when Jenny asked whether we'd build script-pager OR how-to-pager, I clarified they were different artifacts and recommended one tight artifact (the script). Jenny chose both. Architected the two-mode framework around the temporal split (learn vs deliver).
- **Ship Me as third mode + recursive money shot (~13:05):** when Jenny added a "product launch one-pager from design docs + AI chat history + repo" feature, I named it 🚀 Ship Me to complete the triple AND surfaced the recursive demo angle (CharisMaster generates CharisMaster's own launch page on camera — the submission is generated by the submission). This became the demo's headline beat.
- **Sidecar files for v2 vs overwriting v1 (~14:15):** when Studio's v2 Project refactor was in flight but not verified, I drafted `docs/demo-script-v2-draft.md` as a SIDECAR so the v1 script stays intact. Decision gate spelled out at the top of the file: only swap to v2 if Studio renders home + project workspace + a mode workspace by 14:15 PT. Otherwise roll v2 back via Studio chat and use v1.
- **Demo asset pre-cache discipline (~13:00):** wrote `docs/demo-prep.md` with a 7-tab pre-roll checklist where every "click Generate" beat in the script has a pre-generated equivalent tab to cut to if live gen stalls. Failure mitigation as a first-class artifact, not an afterthought.

### What worked

- **Pushing back on the second pivot (charismaster → generic how-to) saved the wedge.** Jenny was about to abandon her differentiator under time pressure. The "honest evaluation table" was the right move — letting her see structurally why Path C beat both alternatives kept the brand AND added the share-loop.
- **Sidecar discipline for v2.** Not overwriting v1 demo script when v2 was building meant zero work lost if v2 failed. Cheap insurance.
- **Recording playbook as a deliverable.** `docs/demo-prep.md` turned the recording phase from "Jenny improvises under time pressure" into "Jenny reads from a checklist." Pre-cached fallback tabs neutralized the "live gen stalls" failure mode.
- **Project context paste blob.** When Jenny screenshotted the rendered v2 Project workspace, I had a paste-ready textarea blob in the repo within 5 minutes, engineered to extract ~9 candidate tasks across all 3 modes.
- **Coordinating via STATUS.md + ownership map.** Four parallel terminals, zero file collisions across the whole session.

### What didn't

- **Auto-mode classifier blocked early pushes.** The global CLAUDE.md "Pre-Push Review" rule applies even in a project whose CLAUDE.md §1 explicitly overrides it for hackathon mode. Cost: ~3 minutes of friction on the first two C commits, until Jenny manually granted permission. Future fix: project-level Bash permission rule baked into `.claude/settings.json` at repo init.
- **Pivoting twice ate ~25 minutes of coordination tax.** Each pivot meant re-syncing 4 terminals, updating CLAUDE.md §0.5, appending STATUS, re-aligning ownership map. The architectural payoff (3-mode + recursive demo) justified it, but the cost was real.
- **Recommended 2 terminals at 1:30 PM, Jenny kept 3.** I called the coordination overhead at the 1-hour mark; the right call was to retire B and C explicitly. Jenny pivoted again instead, which actually justified keeping C active. Lesson: my "retire terminals" recommendation was premature given Jenny's pivot velocity.

### Lessons for future Jenny

1. **Pivot velocity is your superpower AND your tax.** Three direction changes in 3 hours (charismaster → how-to → 3-mode → v2 Project) produced a structurally stronger product. The cost was real but the wedge was worth it. Future: budget pivot overhead explicitly in the schedule.
2. **Recursive demo angles win social engagement.** The "submission made by the submission" moment was the highest-leverage product decision in the whole build. Every founder shipping at a Gemini hackathon should ask: can my product launch ITSELF?
3. **Sidecar files beat overwrites when you don't know which version will land.** Two scripts, two prep checklists, decision gate at the top of each — costs ~5 min more, saves you when one path fails.
4. **A paste-ready context blob is a deliverable, not an afterthought.** Building the AI Studio app is one thing; designing the FIRST PASTE that bootstraps the demo is what makes the recording phase fast.
5. **Pre-cache every demo beat.** The "demo CAN'T fail" mindset turns the recording phase from improv into reading.

---

## Cross-terminal observations (anyone can append)

### Coordination patterns that worked

- STATUS.md heartbeat after every commit (not just at end of session) made other terminals' next sync useful.
- Explicit `**Heads up to <terminal>:**` callouts inside STATUS lines (e.g., 14:05 [A] flagging C that v1 demo script would need rewrite) saved a sync cycle.
- Sidecar files (v1 + v2 demo scripts coexisting) prevented overwrite loss when product direction was in flux.

### Coordination patterns that didn't

- Hand-rolled Next.js scaffold (~30 min of A's time) was thrown out at the AI Studio pivot. Earlier confirmation of "is this an AI Studio hackathon?" would have saved that.
- Terminal D got killed mid-build because its slice (reference URLs + form answers) shrank to ~10 minutes of work once C absorbed the form answers. Less-than-1-hour slices weren't worth a dedicated terminal.

### Open questions for the next hackathon

- [Anyone: add observations / questions worth carrying forward]

---

## How to append your section

If you're A or B and Studio's verified working: open this file, find your section, fill in the bracketed prompts. Commit with `[A]` or `[B]` tag + Co-Authored-By trailer. Push immediately. Append a STATUS.md heartbeat.

If you're a future Jenny doing a retro: append a new `## Retro — <date>` section at the bottom with what shipped, what won, what bombed.
