# Charismaster

> AI apprentice for high-stakes performance. Learns from you AND from the masters, then rewrites you in your own voice.

**Hackathon:** GDG Stanford × Red Bull Basement, 2026-05-31
**Submission cutoff:** 2:30 PM PT
**Domain:** charismaster.com (registered)

---

## One-paragraph pitch

Performers can't watch themselves perform. Founders bomb pitches they'd have nailed if they'd seen the tape the day before. Coaching is $500/hr and only the top 1% can afford it. **Charismaster** is an AI apprentice that watches your video, listens to the room, compares your delivery against the canonical masters of your form (YC Demo Day clips for pitches, TED talks for keynotes, Mulaney/Birbiglia for stand-up), and gives you a side-by-side report plus rewrites in your own voice.

## Why Gemini

- **Native video understanding** — analyzes your delivery + audience response in one call (OpenAI/Claude can't).
- **Long context** — ingests your video + 3 full reference clips in a single multimodal call.
- **YouTube URL ingestion** — reference corpus is just public URLs; no pre-download.

## Modes (v0)

| Mode | Reference corpus (YouTube) |
|---|---|
| Elevator Pitch | 3 public YC Demo Day clips |
| TED-style Talk | Brené Brown / Simon Sinek / Susan Cain |
| Stand-up Set | Mulaney / Birbiglia / 1 more |
| Sales Call (B2B teaser) | placeholder for demo |

## Wedge → Scale (B2B path)

- **Wedge:** Accelerators (YC, Techstars, 500, Antler, Sequoia Arc, a16z START) license per-cohort. Replaces $500/hr human pitch coaches.
- **Scale:** Enterprise L&D + sales enablement. Same engine, reference corpus swaps to "your company's own top performers."
- **TAM:** $400B global coaching + corporate training.

## Stack

- Next.js 15 (app router, TypeScript)
- `@google/generative-ai` SDK (Gemini 1.5 / 2 Pro)
- Tailwind for UI
- Cloud Run for deploy
- Single page + `/api/analyze` route + `/report/[id]` page

## Demo flow (1-min Playcast video)

1. Hook (8s): Jenny on camera — "I'm a YC S26 founder AND did 70 stand-up shows. Different rooms, same problem: you can't watch yourself perform."
2. Upload (10s): real YBuffet pitch tape, select "Elevator Pitch" mode.
3. Analyze (20s): side-by-side report — your hook vs YC top pitches, conviction signal moments, TAM omission flagged, rewrite in Jenny's voice.
4. Quick mode switch (14s): standup mode → Mulaney/Birbiglia reference → joke pacing comparison.
5. Tagline (8s): "One apprentice. Any high-stakes performance."

## 5-min stage pitch (if finalist)

1. Hook (45s) — bombing clip + "the feedback loop in performance is broken"
2. Insight (30s) — coaching is $500/hr, only top 1% can afford it
3. Differentiation (30s) — "Yoodli grades you. We compare you to the people who already mastered the form."
4. Live demo (2 min)
5. Why Gemini (30s) — only model that ingests your video + 3 full reference clips in one call
6. Market (30s) — accelerators wedge → enterprise L&D scale, $400B
7. Ask (15s) — pitch meetings to land first 100 paying users across verticals

## Submission checklist (2:30 PM PT hard cutoff)

- [ ] App running locally and on Cloud Run (`*.run.app` URL fine)
- [ ] One-pager (team + idea)
- [ ] Hosted working prototype
- [ ] 2-min team intro video
- [ ] 1-min prototype demo (Playcast)
- [ ] Repo link
- [ ] Submitted via the hackathon form

## Multi-terminal sync

See `docs/sync-protocol.md`. Each terminal runs:

```bash
cd ~/code/experiments/charismaster && bash .claude/sync-hook.sh
```

…at the start of every turn (or auto-fires via `.claude/settings.json` UserPromptSubmit hook if you restart Claude inside this folder).
