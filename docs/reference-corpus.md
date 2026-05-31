# Reference corpus — verified public YouTube URLs

Owner: Terminal D. Consumer: Terminal A (`lib/reference-corpus.ts`).

Every URL below is **public**, **YouTube-hosted**, and **embeddable** — Gemini's File API ingests public YouTube URLs directly, no pre-download. All links checked 2026-05-31.

If any URL 404s or goes private before the demo, fall back to a sibling URL listed under the same mode.

---

## Mode 1 — Elevator Pitch (YC Demo Day)

Format Gemini should learn: 60-second single-slide pitch. Hook → problem → solution → traction → ask.

**Primary 3 (paste these into `lib/reference-corpus.ts`):**

| # | URL | What it illustrates |
|---|---|---|
| 1 | `https://www.youtube.com/watch?v=PXHvt_0eoZ4` | LIVE @ YC Demo Day (Fall 2025) — multi-founder reel; canonical 60-sec format back-to-back |
| 2 | `https://www.youtube.com/watch?v=-OBE3gRGGz4` | Demo Day 2024 — Winter 2024 batch pitches |
| 3 | `https://www.youtube.com/watch?v=U-cm72TLBm4` | YC Demo Day (Dec 2025) — Fall 2025 batch, most recent format |

**Why these:** YC publishes Demo Day reels but rarely standalone single-founder pitches. Multi-pitch reels are actually BETTER for the corpus — Gemini sees 10+ pitch structures in one ingestion and learns the distribution, not one example.

**Fallback / extra signal:** `https://www.youtube.com/watch?v=4csaHDjUZEM` (Spring 2025 behind-the-scenes — shows what coaches drilled into founders pre-stage)

---

## Mode 2 — TED-style Talk

Format Gemini should learn: 15-20 min keynote. Personal story hook → big-idea reframe → arc with one signature image → close that re-states the title.

**Primary 3:**

| # | URL | Speaker / Talk | What it illustrates |
|---|---|---|---|
| 1 | `https://www.youtube.com/watch?v=iCvmsMzlF7o` | Brené Brown — The Power of Vulnerability (official TED, 2010) | Vulnerability as a hook; research-credentialed storyteller; 67M+ views |
| 2 | `https://www.youtube.com/watch?v=u4ZoJKF_VuA` | Simon Sinek — Start With Why (TEDxPugetSound, 2009) | Golden-circle visual; repetition as a structural device; pacing |
| 3 | `https://www.youtube.com/watch?v=c0KYU2j0TM4` | Susan Cain — The Power of Introverts (official TED, 2012) | Vulnerable opening (suitcase story); contrarian thesis; calm delivery as a deliberate choice |

**Why these:** All three are in the top-20 most-watched TED talks of all time, all officially uploaded by TED or TEDx, all 15-20 min (fits Gemini context comfortably).

---

## Mode 3 — Stand-up Set

Format Gemini should learn: callbacks, escalation, act-outs, specificity, the rule of 3, premise → tag → tag.

**Primary 3 (3rd slot has two options — Jenny picks):**

| # | URL | Comic / Bit | What it illustrates |
|---|---|---|---|
| 1 | `https://www.youtube.com/watch?v=dTi6efpPSZ0` | John Mulaney — Salt and Pepper Diner (Comedy Central, 2013) | Long-form story bit; escalation; specificity (Tom Jones / "What's New Pussycat" 21 times); single-act-out finish |
| 2 | `https://www.youtube.com/watch?v=UZpu9OW1O-U` | Mike Birbiglia — David O. Russell joke (Thank God for Jokes) | Meta-bit about jokes; tension-and-release; conversational pacing |
| 3a | `https://www.youtube.com/watch?v=7sypknCMSFU` | Mike Birbiglia — "Rubbed the Wrong Way" (Netflix is a Joke) | Anecdotal storytelling; physical comedy in delivery |
| 3b | `https://www.youtube.com/watch?v=5S5iZZEtTkg` | John Mulaney — New In Town (full special, 2012) | Full-set structure if Gemini context allows; canonical millennial stand-up |

**Jenny pick:** Use 3a (short Birbiglia clip) for the v0 demo — keeps the corpus light and parses fast. 3b is the heavyweight reference for a deeper analyze call.

**Why these:** All three feature heavily in stand-up writing courses; Mulaney + Birbiglia are stylistically distinct (joke-focused vs. story-focused), so the corpus covers the spread.

---

## Mode 4 — Sales Call (B2B teaser) — TODO

README marks this as placeholder. Likely not demo'd in the 1-min Playcast. Leave empty or hardcode a Patrick Dang / Chris Voss YouTube URL if time allows.

Suggested: `// TODO: real video` per CLAUDE.md rule #2.

---

## Paste-ready snippet for A (`lib/reference-corpus.ts`)

```ts
export const REFERENCE_CORPUS: Record<Mode, string[]> = {
  'elevator-pitch': [
    'https://www.youtube.com/watch?v=PXHvt_0eoZ4',
    'https://www.youtube.com/watch?v=-OBE3gRGGz4',
    'https://www.youtube.com/watch?v=U-cm72TLBm4',
  ],
  'ted-talk': [
    'https://www.youtube.com/watch?v=iCvmsMzlF7o',
    'https://www.youtube.com/watch?v=u4ZoJKF_VuA',
    'https://www.youtube.com/watch?v=c0KYU2j0TM4',
  ],
  'standup': [
    'https://www.youtube.com/watch?v=dTi6efpPSZ0',
    'https://www.youtube.com/watch?v=UZpu9OW1O-U',
    'https://www.youtube.com/watch?v=7sypknCMSFU',
  ],
  'sales-call': [
    // TODO: real video (per CLAUDE.md rule #2)
  ],
};
```

A: this assumes the `Mode` union you wired in `lib/schema.ts`. If your keys differ, adjust — the URL trio is what matters.
