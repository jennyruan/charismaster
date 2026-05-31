# Demo script — v2 (Project + multi-output cards) — DRAFT

> **Status: DRAFT, sidecar file.** Calibrated to the v2 refactor in
> `docs/ai-studio-prompt.md` §5.2 (Project entity owns context + tasks;
> mode workspaces have parallel multi-output cards; per-card refine /
> share / screen-size toggle).
>
> **Use this script IF AND ONLY IF Studio's v2 build is verified working.**
> If v2 fails or you roll back to v1 via Studio chat, use the v1 script in
> `docs/demo-script.md` instead. v1 script stays intact; this file is a
> sidecar, never overwrites.
>
> Decision gate: by 14:15 PT, confirm v2 rendered the home page + a project
> workspace + at least one mode workspace. If yes, swap to this file. If no,
> roll v2 back in Studio chat and run v1.

Drafted 2026-05-31 14:15 PT by Terminal C.

**Total runtime:** 60 seconds, hard cap.
**Recording surface:** OBS or Playcast, 1080p.
**Aspect ratio:** 16:9 with center-safe action so it crops square for socials.

---

## What changed from v1

v1 was single-shot per mode: pick mode → fill form → one output → done. v2's
architecture (Project + workspaces + parallel cards) needs the demo to teach
the viewer the **Project** concept in 8 seconds and show **parallel output
generation** as the AI surface money shot. The opener and the close stay
identical to v1 — they're calibrated and working.

---

## Pre-roll checklist (~15 min before rolling tape)

Same OBS / lighting / mic setup as `docs/demo-prep.md` §0.3. Tabs differ:

| Tab | URL | Pre-load before rolling |
|---|---|---|
| 1 | `*.run.app/` (home) | Project list visible. At least one project ("YBuffet pitch — Stanford GDG") pre-created. 3-card mode launcher visible below. |
| 2 | `*.run.app/project/<id>` (YBuffet project workspace) | Context tab pre-filled: paste from `docs/one-pager.md` "What CharisMaster does" section + 1 reference URL. Task list pre-populated with 4 AI-generated tasks: (a) "Draft 60s pitch for Stanford GDG judges", (b) "Practice opening line with rebuttal to 'Isn't this Yoodli?'", (c) "Q&A prep — 3 likely VC pushbacks", (d) "Launch announcement for CharisMaster on X / LinkedIn". |
| 3 | `*.run.app/save-me` (Save Me workspace, mid-state) | Tasks (a)+(b)+(c) imported as 3 chips. "Generate 3 outputs" button visible, not yet clicked. |
| 4 | `*.run.app/save-me` (Save Me workspace, post-generation) | The 3 cards from tab 3 fully rendered. **PRE-GENERATE THIS.** This is the live-demo fallback if click-to-generate stalls. |
| 5 | `*.run.app/ship-me` (Ship Me workspace, mid-state) | Task (d) "Launch announcement for CharisMaster" imported as 1 chip. "Generate 1 output" button visible. |
| 6 | `*.run.app/ship-me` (Ship Me workspace, post-generation) | The CharisMaster launch card fully rendered. **PRE-GENERATE THIS.** This is THE MOST IMPORTANT fallback — the recursive money shot must work. |
| 7 | `*.run.app/coach-me` (Coach Me workspace, not used in demo) | Pre-loaded as a backup if Jenny wants to mention Coach Me visually. |

**Critical pre-cache discipline**: every "click Generate" beat in the script
below must have a pre-generated equivalent ready in another tab. If the live
gen stalls past 3 seconds, voiceover-bridge and cut to the pre-cached tab.

---

## Script — verbatim

### 0:00–0:08 (Jenny on camera, direct address) — 8s

> "I've bombed pitches. I've bombed stand-up sets. I've shipped products no one heard about. The common thread — **you can't see what you're sending into the room.**"

**Tone:** flat, honest, no smile. Look at lens, not script.
**Cut:** match-cut to screen capture as "into the room" lands.

### 0:08–0:18 (Project workspace intro) — 10s

Show tab 2 — the YBuffet project workspace. Camera holds on the screen.

Voiceover, slower than the opener:
> "CharisMaster works in projects. Here's mine for today. My context — past pitches, the judges' bios. CharisMaster reads it and writes me a task list."

Mouse hovers over the 4 task cards as they're named.

> "Four tasks. Pick which ones to do."

### 0:18–0:33 (Save Me workspace + parallel generation) — 15s

Cut to tab 3 (Save Me workspace with 3 chips pre-loaded).

Voiceover:
> "Save Me. I import three tasks from the project. Pitch draft. Opening rebuttal. Q&A prep."

Click "Generate 3 outputs."

If live: hold for 2-3 seconds as cards stream in. If slow: cut to tab 4 (pre-generated).

Voiceover overlays the streaming cards:
> "Three parallel Gemini calls. Three personalized one-pagers — one per task. **In thirty seconds.** What used to take a $500-an-hour coach an afternoon."

Camera zooms into the middle card (the Q&A prep one). Quick beat: flip its screen-size toggle 🖥 → 📱.

> "Fold one into my pocket."

### 0:33–0:50 (Ship Me workspace — the meta moment) — 17s

Cut to tab 5 (Ship Me workspace with 1 chip pre-loaded).

Voiceover, slower:
> "One more task in the project. **Launch CharisMaster.**"

Click "Generate 1 output."

If live: hold for 2-3 seconds. If slow: cut to tab 6 (pre-generated).

The CharisMaster launch card streams in. Camera slowly zooms.

Voiceover, the closing beat:
> "**The launch page for CharisMaster — was just generated by CharisMaster.** The submission was made by the submission. Built solo, three hours, Gemini multimodal."

Beat. Hold on the rendered Ship Me card.

### 0:50–0:60 (Jenny back on camera, CTA) — 10s

> "**Try yours at charismaster.com.** Coach you. Save you. Ship you."

**End frame:** logo + URL hold for 1 second. Final frame is shareable as a still.

---

## What this script deliberately does

- **Teaches Project entity in 10s** (0:08–0:18). Viewers see the concept without us labeling it as "an architectural primitive."
- **Shows parallel generation as visible AI surface** (0:18–0:33). Three cards streaming = visceral "this is doing real work" moment that v1 single-output didn't have.
- **Preserves the recursive money shot** (0:33–0:50). The Ship Me-on-CharisMaster beat still lands.
- **Keeps the opener + close identical to v1**. Those words tested fine in the v1 plan; no reason to risk new copy at the wire.

---

## If the live demo breaks during recording

Same fallback discipline as v1:
1. Don't stop. Voiceover bridge: *"…here's what it generated for me earlier today."*
2. Cut to the pre-cached tab (4 for Save Me, 6 for Ship Me).
3. Continue as if nothing happened.

---

## Captions / open captions

Burn open captions onto the whole video. Verbatim from the script above.

---

## Social posts (UPDATED for v2's multi-output story)

**Twitter / X**:
```
I've bombed pitches. I've bombed stand-up sets.
I've shipped products no one heard about.
All three problems: you can't see what you're sending into the room.

So I built CharisMaster.

I work in projects. CharisMaster reads my context, writes my task list,
and generates personalized one-pagers in parallel.

🎯 Save Me — opener, beats, close, comebacks
🎓 Coach Me — masters' principles + drills
🚀 Ship Me — launch page for the thing you built

The launch page in the demo? CharisMaster wrote it for itself.

Built solo in 3 hours at GDG Stanford × Red Bull Basement.
Try it: charismaster.com

[60-sec demo]
```

**LinkedIn**:
```
Performers can't watch themselves perform. Founders bomb pitches
they would have nailed if they'd seen yesterday's tape. Builders
ship products no one ever hears about.

Three different versions of the same problem: you can't see what
you're sending into the room.

CharisMaster is the AI apprentice for all three.

You work in projects. Drop in your context — past pitches, slides,
audience bios. CharisMaster turns it into an editable task list,
then generates personalized one-pagers in parallel:

🎯 Save Me — opening, beats with timing, close + ask, comebacks
🎓 Coach Me — three master principles + traps + drills + watch-next
🚀 Ship Me — product launch page from your design docs + repo

The CharisMaster launch page I'm posting alongside this? CharisMaster
wrote it itself, in parallel with the rest of my hackathon submission.

Built solo on Gemini multimodal at GDG Stanford × Red Bull Basement,
May 31 2026.

Try it: charismaster.com
```

---

## Why this script wins the 5 judging axes (vs v1)

| Axis | v1 score | v2 script lift |
|---|---|---|
| Technical Feasibility | 7 | **+1** — parallel generation visibly demonstrates real Gemini surface |
| Innovation & Novelty | 7 | **+1** — Project + task list + parallel multi-output is a sharper architectural story than single-shot |
| Real-World Applicability | 8 | **0** — same use case, same need |
| Market Potential & Fundability | 8 | **+1** — Project workspace looks like real product, not a demo toy |
| GTM / Social Traction | 7 | **+1** — three cards streaming in is more visually shareable than one form rendering one result |

---

## Decision: when to swap to this script

- By 14:15 PT: verify v2 has rendered the home page + a project workspace.
- If yes: use this script.
- If no: roll v2 back in Studio chat (ask: "revert the project refactor — go back to the per-mode single-shot generation flow") and use v1 `docs/demo-script.md`.
- Either way, do NOT rewrite docs/demo-script.md — keep it as the v1 fallback so nothing is destroyed.
