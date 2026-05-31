# Submission form — paste-ready answers

Owner: Terminal D. Target: Jenny pastes into the hackathon form at 2:30 PM PT.

**Hackathon:** GDG Stanford × Red Bull Basement, SF 2026-05-31
**Cutoff:** 2:30 PM PT

Fields below cover the standard hackathon form (team, project, prototype, demo). Pre-filled from README + CLAUDE.md. URLs that don't exist yet are marked `<FILL>`.

---

## Project name

**Charismaster**

(Domain: charismaster.com, registered.)

---

## Team name

**Charismaster** (solo founder)

---

## Team members

**Jenny Ruan** — Solo founder.
- Background: 3 issued patents (2016, takeout packing system), Master's in Mechanical Engineering (acoustics) from Wayne State, ex-NVH engineer at Fiat Chrysler, ex-Technical Program Manager at HiRain Technologies (3.5 yrs).
- Pivoted to full-stack software late 2025 — now ships Next.js + Go + PostgreSQL solo as founder of YBuffet (structured-communication SaaS for founders/investors/providers).
- Voice/AI work: built Vhostwriter at YC Voice Agents Hackathon (Apr 2026, Cactus + Gemma 4).
- Stage credibility: 70+ stand-up comedy shows in H2 2024 — the lived-experience source for Charismaster's stand-up mode.
- Based in San Francisco. O-1B visa (arts/entertainment).

---

## One-paragraph pitch

Performers can't watch themselves perform. Founders bomb pitches they'd have nailed if they'd seen the tape the day before. Coaching is $500/hr and only the top 1% can afford it. **Charismaster** is an AI apprentice that watches your video, listens to the room, compares your delivery against the canonical masters of your form (YC Demo Day clips for pitches, TED talks for keynotes, Mulaney/Birbiglia for stand-up), and gives you a side-by-side report plus rewrites in your own voice.

---

## Why Gemini (required — this is a Gemini hackathon)

- **Native video understanding.** Gemini analyzes your delivery + audience response in one multimodal call. OpenAI and Claude can't.
- **Long context.** Ingests your video + 3 full reference clips in a single call — no chunking, no orchestration.
- **YouTube URL ingestion.** The reference corpus is just public URLs; Gemini pulls them directly. Zero pre-download, zero storage cost.

This product is **not possible** without a model that takes raw video in and emits structured analysis out. Gemini is the only model in market that does this end-to-end.

---

## Stack

- Next.js 15 (App Router, TypeScript)
- `@google/generative-ai` SDK (Gemini 1.5 / 2 Pro)
- Tailwind CSS (defaults, no custom system)
- Cloud Run (Docker) for deploy
- Zod for structured output schema

---

## Demo video (1-min Playcast)

`<FILL: paste Playcast URL after recording>`

**Demo flow:**
1. Hook (8s) — Jenny on camera: "I'm a YC S26 founder AND did 70 stand-up shows. Different rooms, same problem: you can't watch yourself perform."
2. Upload (10s) — real YBuffet pitch tape, "Elevator Pitch" mode.
3. Analyze (20s) — side-by-side report: your hook vs YC top pitches, conviction signal moments, TAM omission flagged, rewrite in Jenny's voice.
4. Mode switch (14s) — standup → Mulaney/Birbiglia reference → joke pacing comparison.
5. Tagline (8s) — "One apprentice. Any high-stakes performance."

---

## Team intro video (2-min)

`<FILL: paste team-intro URL after recording — script is in docs/team-intro-script.md from Terminal C>`

---

## Hosted prototype URL

`<FILL: paste Cloud Run *.run.app URL after Terminal B's deploy.sh succeeds>`

Backup: `charismaster.com` (domain mapping after cutoff if time).

---

## Repo URL

`<FILL: paste GitHub URL — public if rules allow, private invite to judges otherwise>`

---

## Wedge → Scale (B2B path) — if form asks for market/business

- **Wedge:** Accelerators (YC, Techstars, 500, Antler, Sequoia Arc, a16z START) license per-cohort. Replaces $500/hr human pitch coaches.
- **Scale:** Enterprise L&D + sales enablement. Same engine, reference corpus swaps to "your company's own top performers."
- **TAM:** $400B global coaching + corporate training.

---

## Differentiation — if asked

**Yoodli grades you. Charismaster compares you to the people who already mastered the form.**

Existing tools (Yoodli, Poised, Verble) score generic speaking metrics — filler words, pace, eye contact. Charismaster does what a human coach does: holds your performance against canonical examples of the form and tells you what's missing.

---

## Modes shipped (v0)

| Mode | Reference corpus |
|---|---|
| Elevator Pitch | 3 public YC Demo Day reels |
| TED-style Talk | Brené Brown / Simon Sinek / Susan Cain |
| Stand-up Set | Mulaney / Birbiglia / Birbiglia |
| Sales Call (B2B teaser) | placeholder for v1 |

URLs in `docs/reference-corpus.md`.

---

## Pre-submit checklist (run this list at 2:25 PM PT)

- [ ] All 3 `<FILL>` URLs above replaced
- [ ] Cloud Run URL responds 200 on `/`
- [ ] One real video uploaded successfully end-to-end (Jenny's YBuffet pitch)
- [ ] Repo link works (logged out browser check)
- [ ] Playcast video plays without auth
- [ ] Team-intro video plays without auth
- [ ] Submission form opened, all fields filled, hit submit
- [ ] Screenshot the submission confirmation
