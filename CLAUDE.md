# Charismaster — project rules

Hackathon project. GDG Stanford × Red Bull Basement, SF 2026-05-31.
Read `README.md` first for the locked one-page design.

---

## 0. Build target: Google AI Studio (READ FIRST — supersedes ownership map)

We build through **Google AI Studio Build mode** (`aistudio.google.com/apps`),
NOT a hand-rolled Next.js app. Studio scaffolds the app, wires Gemini, and
deploys to Cloud Run. Claude Code's job is to produce the **one-shot build
prompt** + supporting design assets that get pasted into Studio.

**Read `docs/ai-studio-build-rules.md` before doing anything else.** It
contains the canonical prompt anatomy, per-terminal impact (A and B pivot;
C and D mostly unchanged), and the build-prompt skeleton to fill in.

If you were about to hand-write `package.json`, `app/page.tsx`, `lib/gemini.ts`,
`/api/analyze`, Dockerfile, or `scripts/deploy.sh` — **stop** and read §0 first.

Captured 2026-05-31 mid-hackathon by Terminal A on Jenny's instruction.

---

## 0.5 Product framing — LOCKED three-mode framework

> **CharisMaster: Coach Me, Save Me, or Ship Me.**
> Three modes from one engine. Same Gemini multimodal call
> (text/audio/link/repo/design-doc in → reference-grounded **graphical**
> one-pager out), different output template per mode. User can iteratively
> refine the output by throwing in additional references + prompts.

| Mode | User intent | Output | Time horizon |
|---|---|---|---|
| 🎓 **Coach Me** | "I want to get better at X" | Graphical one-pager: principles drawn from masters, traps to avoid, drills, watch-next | Weeks/months |
| 🎯 **Save Me** | "I have [X] tomorrow, help" | Graphical one-pager: opening, beats with timestamps, close + ask, comeback lines | Tonight |
| 🚀 **Ship Me** | "I built [X], help me launch it" | Graphical one-pager: product name, builder info, description, feature list, product link, use guidance | Launch day |

**Unifying through-line:** CharisMaster helps you **land your message** —
whether you're learning the form (Coach), performing it (Save), or launching
something new into the world (Ship).

**Both outputs are GRAPHICAL one-pagers** (Nano Banana flourishes + structured
layout). The user picks one of several screen-size variants on the output page
(phone / tablet / desktop / print) and the layout reflows accordingly. The
screen-size toggle is explicit UI on the output page, not just CSS responsive
behavior — the user chooses which size they want for their use case (Save Me
mode often = print or phone; Coach Me mode often = desktop or shareable image).

**Iterative refinement:** the output page includes a "refine" panel. The user
can paste another reference URL, upload more material, or add a free-text prompt
("make the close more aggressive", "drop the third trap"). Hitting refine runs
another Gemini call with the previous output + the new input as context, and
re-renders.

The output spec for both modes lives in `docs/output-spec.md`. Terminal A pastes
this into the AI Studio Build prompt's `<output>` section. Do NOT diverge from
the spec without updating it in `docs/output-spec.md` first so all terminals
see the change in git.

Locked 2026-05-31 12:25 by Jenny; updated 12:42 (mode rename + graphical for
both + screen-size toggle + iterative refinement). Supersedes the original
single-mode "side-by-side report" framing in `README.md` and
`docs/ai-studio-build-rules.md` §4. README will be updated by Terminal A on
next pass.

---

## 1. Push to main (overrides global Branch Safety)

This is a hackathon repo with multiple Claude terminals contributing in
parallel for ~2.5 hours. Branch-and-PR friction is unaffordable.

**Rules:**
- Commit and push directly to `main`. No feature branches. No PRs.
- Print `git diff origin/main --stat` before every push **but do not pause
  for confirmation** — print, push, move on.
- Use the global commit message format (Co-Authored-By trailer included).
- If a push fails because someone else pushed, `git pull --rebase` and retry.

This rule supersedes the global `~/.claude/CLAUDE.md` Branch Safety and
Pre-Push Review sections **for this repo only**.

---

## 2. No mock data — use Jenny's real videos

Demo reads real. No fake users, no placeholder transcripts, no fabricated
"YC pitch by Jane Smith." If you need an example for the demo, use:

- Jenny's actual YBuffet elevator pitch tape
- Jenny's actual stand-up set clips (she has 70 shows of footage)
- Real public YouTube URLs for the reference corpus (Brené Brown TED, Mulaney clip, public YC Demo Day clips)

If a video isn't available yet, leave a `// TODO: real video` marker and fail loud with an empty state. Never fabricate a user-facing example.

Pre-commit grep self-check:
```bash
git grep -E '(@example\.com|Lorem|John Doe|Jane Smith|sampleUser|mockPitch|fakeTranscript)'
```
Should return nothing.

---

## 3. Design — Tailwind defaults

No design system. Tailwind defaults. Black text on white, sensible spacing,
real content over polish. The 1-min demo video doesn't show pixel-perfection.

---

## 4. Multi-terminal coordination

Multiple Claude terminals open in parallel. To avoid collisions:

**Ownership map** (update this section as work shifts):
- **Terminal A (Opus, scaffold + Gemini):** `package.json`, `next.config.ts`, `tsconfig.json`, `Dockerfile`, `app/layout.tsx`, `app/page.tsx`, `app/api/analyze/route.ts`, `lib/gemini.ts`, `lib/schema.ts`, `lib/reference-corpus.ts`, `lib/report-store.ts`, `.env.example`
- **Terminal B (Opus, deploy + smoke test):** `scripts/deploy.sh`, `scripts/smoke.sh`, `scripts/setup.sh`
- **Terminal C (Opus, output spec + submission docs):** `docs/output-spec.md` (two-mode one-pager layout spec for AI Studio prompt — supersedes hand-written `app/report/[id]/page.tsx` per §0 + §0.5), `docs/one-pager.md`, `docs/demo-script.md`, `docs/team-intro-script.md`
- **Terminal D (Opus, reference corpus research + submission form):** `docs/reference-corpus.md` (verified YouTube URLs per mode for A to paste into `lib/reference-corpus.ts`), `docs/submission-form-answers.md` (pre-filled hackathon form). Read-only on everything else.

**Protocol:**
- Before editing any file, `git pull --rebase` + check `git status`.
- After landing a change, `git push` immediately so others see it.
- If you're about to edit a file outside your ownership slice, comment in
  this file or ping in the zsh terminal first.
- Pick a `tag` at session start (A / B / C / scaffold / gemini / ui) and
  use it consistently in STATUS.md entries.

---

## 5. File layout (target)

```
charismaster/
├── app/
│   ├── layout.tsx
│   ├── page.tsx                  ← upload + mode-selector
│   ├── report/[id]/page.tsx      ← side-by-side report UI
│   └── api/
│       └── analyze/route.ts      ← Gemini call
├── lib/
│   ├── gemini.ts                 ← SDK wrapper
│   ├── reference-corpus.ts       ← hardcoded YouTube URLs per mode
│   └── schema.ts                 ← Zod schema for structured output
├── Dockerfile                    ← Cloud Run
├── .env.example
├── CLAUDE.md
├── README.md
├── STATUS.md
└── docs/
    └── sync-protocol.md
```

---

## 6. Sync ritual (read this every turn)

Multiple Claude Code terminals are running in parallel. Conversation context
never crosses terminals; only files + git do. To stay current:

**At the start of every turn in this project, run:**
```bash
bash .claude/sync-hook.sh
```

This script auto-fetches `origin/main`, fast-forwards if you're clean and
behind, then prints `STATUS.md` tail + recent `git log` + any uncommitted
files. Output goes into your context.

**After every meaningful action** (commit, decision, blocker, handoff),
append one line to `STATUS.md` and push immediately:
```
- HH:MM [tag] short description — files or commit short-sha
```

**Auto-fire:** `.claude/settings.json` wires the sync hook to fire on every
UserPromptSubmit. After Jenny restarts Claude Code inside this folder once,
sync runs automatically every prompt — closest to real-time the harness allows.

See `docs/sync-protocol.md` for details and conflict handling.

---

## 7. Submission checklist (2:30 PM PT hard cutoff)

- [ ] App running locally
- [ ] Deployed to Cloud Run (`*.run.app` URL OK; domain mapping after cutoff)
- [ ] Gemini analyze loop works end-to-end on Jenny's real YBuffet pitch
- [ ] Report UI renders side-by-side comparison
- [ ] One-pager written
- [ ] 1-min Playcast demo recorded
- [ ] 2-min team intro recorded
- [ ] Repo public/private link in submission
- [ ] Submitted via hackathon form
