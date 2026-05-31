# Output spec — CharisMaster three-mode graphical one-pagers

> Canonical spec for the three output artifacts CharisMaster produces. Terminal A
> pastes the relevant sections into the AI Studio Build prompt. Do NOT edit the
> prompt's output format without updating this file first.

Locked 2026-05-31 12:25 PT, updated 12:42 (rename + both-graphical + screen-size
toggle + iterative refinement), updated 13:05 (added Ship Me mode — third mode
for product launch pagers) per CLAUDE.md §0.5.

---

## 0. Shared constraints (apply to BOTH modes)

- **Both outputs are GRAPHICAL one-pagers** — not text reports. Nano Banana
  generates visual elements (header illustration, mode-specific glyphs, optional
  background watermark). Layout is intentional, not boilerplate.
- **User-selected screen-size variant** (see §1.5). Phone / tablet / desktop /
  print. User picks. Layout reflows per choice.
- **Iterative refinement** (see §4). The user adds more references or free-text
  prompts; we re-call Gemini with the previous output as context and re-render.
- Typography: Tailwind defaults only. Serif headings (`font-serif`), sans body.
  Black on white. One accent color per mode (Coach Me = indigo, Save Me = amber).
- **No mock data** anywhere — empty states only.
- **Bottom strip on every output**: "Made with CharisMaster — charismaster.com"
  + a "Share" button that copies a public-image link.

---

## 1. Mode toggle (input page)

This is the first thing the user sees. Wireframe:

```
┌────────────────────────────────────────────────────────────────┐
│  CharisMaster                                                  │
│  Coach me, save me, ship me. Land your message either way.     │
├────────────────────────────────────────────────────────────────┤
│  Which do you need?                                            │
│                                                                │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐            │
│  │ 🎓 COACH ME  │ │ 🎯 SAVE ME   │ │ 🚀 SHIP ME   │            │
│  │              │ │              │ │              │            │
│  │ I want to    │ │ I have a     │ │ I built a    │            │
│  │ get better   │ │ [pitch/talk/ │ │ thing. Help  │            │
│  │ at this over │ │ set]         │ │ me launch    │            │
│  │ time.        │ │ tomorrow.    │ │ it.          │            │
│  │              │ │              │ │              │            │
│  │ Reusable     │ │ Single-use   │ │ Shareable    │            │
│  │ how-to.      │ │ cheat sheet. │ │ launch page. │            │
│  └──────────────┘ └──────────────┘ └──────────────┘            │
└────────────────────────────────────────────────────────────────┘
```

All three cards clickable. Selection advances to mode-specific input form.

### Coach-Me input form

```
What skill do you want to master?

  [ text input — e.g. "YC Demo Day elevator pitch" ]

Pick a form so we pull the right masters (optional):
  ( ) Pitch   ( ) TED talk   ( ) Stand-up   ( ) Sales call

Paste a past clip of you trying this skill (optional — calibrates the
how-to to where you are today):
  [ url input or upload ]

[ Generate my Coach Me one-pager ]
```

### Save-Me input form

```
What are you performing, and when?

  [ text input — e.g. "YBuffet pitch to Stanford GDG judges, today 4 PM" ]

What outcome do you want?
  [ text input — e.g. "VC pitch meetings" ]

Audience — who's in the room? (paste names, bios, or a screenshot)
  [ textarea ]
  [ image upload — Gemini OCRs screenshots ]

Time limit?
  [ 30s ] [ 60s ] [ 2 min ] [ 5 min ] [ custom ]

Paste a past performance of yours (optional — keeps your voice in the script):
  [ url input or upload ]

Pick a form (optional):
  ( ) Pitch   ( ) TED talk   ( ) Stand-up   ( ) Sales call

[ Generate my Save Me one-pager ]
```

### Ship-Me input form

```
What did you build? (give it a working name)

  [ text input — e.g. "CharisMaster" ]

Drop in everything you have. Any of these is enough; more is better.

  📄 Design docs / plans / README:
     [ paste markdown / textarea ]
     [ + upload file (.md, .pdf, .txt) ]

  💬 AI chat history (your build conversation):
     [ paste transcript / textarea ]
     [ + upload (.json, .md) ]

  📦 Code repo (public GitHub URL — Gemini reads the README + file tree):
     [ url input ]

  🔗 Live product link (if it's already deployed):
     [ url input ]

  ✍️  Anything else you want to say about it:
     [ textarea — your voice, your story ]

Who's the builder? (this goes on the page; you can stay anonymous)
  [ text input — name, handle, or "anonymous solo builder" ]

Pick a launch context (optional — shapes the framing):
  ( ) Show HN   ( ) Product Hunt   ( ) hackathon submission
  ( ) Twitter launch   ( ) investor email   ( ) personal portfolio

[ Generate my Ship Me one-pager ]
```

---

## 1.5 Screen-size toggle (output page)

Above the rendered one-pager, a 4-button toggle:

```
View as:  [ 📱 Phone ] [ 📲 Tablet ] [ 🖥 Desktop ] [ 🖨 Print ]
```

| Variant | Width | Layout | Use case |
|---|---|---|---|
| 📱 Phone | 375px | Single column, big tap targets, action buttons sticky at bottom | Save Me on the walk to the room |
| 📲 Tablet | 768px | Two columns where called out | Reading on iPad before the talk |
| 🖥 Desktop | 1280px | Full multi-column layout, generous whitespace | Coach Me study session |
| 🖨 Print | US Letter (816×1056 @ 96dpi) | Print-optimized single page, hides buttons | Fold and pocket Save Me, or pin Coach Me to wall |

Toggle is client-side: pre-rendered DOM in 4 size variants via Tailwind container
queries OR a forced viewport class. Pick whichever AI Studio scaffolds cleanly.

The selected variant determines what the **Share** button captures: PNG export
matches the currently-viewed variant.

---

## 2. 🎓 Coach Me mode — "How to [skill]" one-pager

### 2.1 Title block

| Field | Source | Treatment |
|---|---|---|
| Title | `How to master <skill>` | `text-3xl font-serif font-bold`, top-left |
| Subtitle | One sentence from a master that defines the form | italic, gray-600, pull-quote |
| Meta strip | "Based on N reference performances + your <upload>" | `text-xs uppercase tracking-wide text-gray-500` |
| Header illustration | Nano Banana — see §2.7 | Top-right, hidden on phone variant |

### 2.2 "The 3 things masters do"

3 principles. Each = Gemini synthesis of patterns ACROSS the reference corpus.

| Field | Source | Treatment |
|---|---|---|
| `principles[].number` | 1, 2, 3 | Big numeral, `text-5xl font-serif text-indigo-600` |
| `principles[].title` | Short imperative ("Open with a number, not a story") | `text-lg font-semibold` |
| `principles[].example` | 1-line quote from a real reference video w/ attribution | `text-sm italic`, attribution in `text-xs text-gray-500` |
| `principles[].why_it_works` | 1-sentence mechanic | `text-sm text-gray-700` |

Layout: 3 cards column (phone) → 3 cards row (tablet+).

### 2.3 "3 traps to avoid"

Gap-analysis distilled from reference corpus.

| Field | Source | Treatment |
|---|---|---|
| `traps[].title` | Short imperative ("Don't bury the ask") | `font-semibold` |
| `traps[].why_it_fails` | 1 sentence | `text-sm` |
| `traps[].master_doing_it_right` | 1-line example | `text-xs italic text-gray-600` |

Visual: small hand-drawn ⚠️ glyph per trap (Nano Banana, generated once, reused).

### 2.4 "Drills you can do today"

3 specific, time-boxed practice exercises.

| Field | Source | Treatment |
|---|---|---|
| `drills[].title` | "Mirror practice: open + close, 5 min" | `font-semibold` |
| `drills[].steps` | 2-3 bullet steps | `<ul>` with checkbox markers |
| `drills[].time_estimate` | "5 min" / "10 min" | small badge, top-right of card |

Layout: 3 cards row on desktop.

### 2.5 "Watch next"

2–3 reference videos w/ short why-to-watch + clickable URL.

| Field | Source | Treatment |
|---|---|---|
| `watch_next[].title` | Video title + speaker | `font-semibold text-sm` |
| `watch_next[].url` | YouTube URL | underlined link |
| `watch_next[].why` | 1-line specific reason | `text-xs text-gray-600` |

### 2.6 Coach-Me footer

- Generated date + mode label.
- "Made with CharisMaster — charismaster.com".
- Share button.

### 2.7 Coach-Me visual flourish (Nano Banana)

Generate ONE hand-illustrated header banner: stylized line drawing of a person
at a podium with motion lines suggesting energy.

```
Hand-drawn ink-style illustration, black lines on white, sketchnote
aesthetic, single subject: a confident speaker at a wooden lectern,
gesturing outward, simple background. No text. Square aspect ratio.
```

---

## 3. 🎯 Save Me mode — "[Performance], [date]" one-pager

### 3.1 Title block

| Field | Source | Treatment |
|---|---|---|
| Title | `<user-described occasion>` e.g. "YBuffet → Stanford GDG, May 31 4 PM" | `text-3xl font-serif font-bold` |
| Subtitle | User's stated desired outcome | `text-base text-gray-700` |
| Time-limit badge | "60 seconds" | amber-100 background pill |
| Header illustration | Nano Banana — see §3.7 | Top-right, hidden on phone variant |

### 3.2 "Your opening (15s)"

| Field | Source | Treatment |
|---|---|---|
| `opening.line` | The exact opening (in user's voice) | Large monospace quote, `text-xl`, indented |
| `opening.delivery_hint` | "Look up, pause 1 beat, then speak. No 'Hi everyone.'" | `text-xs uppercase tracking-wide text-amber-700` |
| `opening.why_this_opens_strong` | 1 sentence tying to a reference master | `text-xs italic text-gray-600` |

### 3.3 "Your beats" — the timeline

3–5 beats, vertical timeline.

| Field | Source | Treatment |
|---|---|---|
| `beats[].timestamp` | `0:15–0:30` ranges | `font-mono text-sm text-amber-700`, left rail |
| `beats[].line` | The actual sentence(s) | `text-base font-medium` |
| `beats[].delivery_hint` | "Drop your voice on 'broken'. Land the joke." | `text-xs uppercase tracking-wide text-amber-700` |
| `beats[].safety_net` | 1-line backup if they freeze | `text-xs text-gray-500 italic` |

Layout: vertical timeline w/ timestamp rail + content. Connecting line between
beats. Same layout across all 4 screen-size variants — this layout works at any
width.

### 3.4 "Your close + ask"

| Field | Source | Treatment |
|---|---|---|
| `close.line` | The exact close sentence | Large quote, `text-xl` |
| `close.ask` | "Pitch meeting next week." | Bold, indigo accent |
| `close.delivery_hint` | "Hold eye contact. Don't fill silence." | `text-xs uppercase tracking-wide text-amber-700` |

### 3.5 "If they push back on…"

2–3 anticipated objections w/ prepared responses.

| Field | Source | Treatment |
|---|---|---|
| `comebacks[].objection` | "Isn't this just Yoodli?" | `font-semibold text-sm` |
| `comebacks[].response` | 1-2 sentence prepared answer in user's voice | `text-sm` |

Layout: sidebar on desktop/tablet, stacked on phone.

### 3.6 "Reference" footer

"Calibrated against [your past clip] + [master 1] + [master 2]. Generated by
CharisMaster — charismaster.com." Plus share button.

### 3.7 Save-Me visual flourish (Nano Banana)

Generate ONE hand-illustrated visual: a vertical timeline with 4 numbered
circles connected by a curved line, each circle slightly different size to
suggest rhythm.

```
Hand-drawn ink-style illustration, black lines on white, sketchnote
aesthetic: a vertical timeline with 4 numbered circles connected by
a curved line, each circle slightly different size to suggest rhythm.
No text labels. Tall narrow aspect ratio.
```

---

## 3.5 🚀 Ship Me mode — Product launch one-pager

> Takes a builder's raw artifacts (design docs, AI chat history, repo URL,
> live link, freeform notes) and synthesizes a polished product launch page
> with the structure of a Show HN / Product Hunt / hackathon submission.

### 3.5.1 Title block

| Field | Source | Treatment |
|---|---|---|
| Product name | User input OR Gemini-extracted from design docs / repo | `text-4xl font-serif font-bold`, top-left |
| Tagline | One-sentence value prop — Gemini synthesizes from inputs in builder's voice | `text-lg font-medium text-gray-700`, italic |
| Builder credit | "Built by [name/handle]" or "Built by an anonymous solo builder" | `text-sm text-gray-600` |
| Launch context badge | "🚀 Show HN" / "🏆 Hackathon submission" / etc. | violet-100 background pill |
| Header illustration | Nano Banana — see §3.5.7 | Top-right, hidden on phone variant |

### 3.5.2 "What it is" — product description

| Field | Source | Treatment |
|---|---|---|
| `description.paragraph` | 2-3 sentence what-it-does in plain language. Synthesizes ALL inputs. No marketing fluff. | `text-base leading-relaxed` |
| `description.who_for` | "For [audience]" — 1 sentence | `text-sm text-gray-700` |
| `description.why_now` | 1 sentence — what shifted that makes this possible / needed now | `text-xs italic text-gray-600` |

### 3.5.3 "Features" — what it does

3–6 features. Each is a verb-led card.

| Field | Source | Treatment |
|---|---|---|
| `features[].title` | Verb-led ("Generate cheatsheets from any past performance") | `font-semibold` |
| `features[].description` | 1 sentence, concrete | `text-sm` |
| `features[].evidence` | Optional: link to live example / repo file / screenshot | `text-xs underlined link` |

Layout: 3 cards row on desktop, 2 on tablet, 1 on phone.

### 3.5.4 "Try it" — links + use guidance

| Field | Source | Treatment |
|---|---|---|
| `links.product_url` | The live product URL | Big primary button, full width, indigo |
| `links.repo_url` | GitHub URL | Secondary button |
| `links.demo_url` | Video / Loom (if provided) | Secondary button |
| `use_guidance.first_step` | "Paste a YouTube URL of a pitch you bombed" — the literal first action | `text-base font-medium` |
| `use_guidance.expected_output` | "You'll get a one-page cheatsheet in 30 seconds" — sets expectation | `text-sm` |
| `use_guidance.power_tip` | One non-obvious move ("Use the Refine panel to add Sam Altman's framework") | `text-xs italic text-gray-600` |

### 3.5.5 "How it was built" — builder context

Optional section, only renders if user provided enough builder voice in inputs.

| Field | Source | Treatment |
|---|---|---|
| `built_story.stack` | "Built on Gemini multimodal, AI Studio Build, Cloud Run" | `font-mono text-xs` chip list |
| `built_story.time` | "Three hours, solo, at GDG Stanford × Red Bull Basement" | `text-sm italic` |
| `built_story.next` | "Next: pilots with 3 accelerators" | `text-sm` |

### 3.5.6 Ship-Me footer

- Generated date.
- "Made with CharisMaster — charismaster.com".
- Share button (PNG export of the page — the share artifact for Twitter / HN / Product Hunt).

### 3.5.7 Ship-Me visual flourish (Nano Banana)

Generate ONE hand-illustrated visual: a paper airplane mid-launch with a
small trailing arc.

```
Hand-drawn ink-style illustration, black lines on white, sketchnote
aesthetic, single subject: a paper airplane mid-launch with a small
trailing arc of motion lines, suggesting forward momentum. No text.
Square aspect ratio.
```

### 3.5.8 Ship Me JSON contract

```jsonc
{
  "mode": "ship_me",
  "version": 1,
  "product_name": "CharisMaster",
  "tagline": "An AI apprentice for high-stakes performance.",
  "builder_credit": "Built solo by Jenny Ruan",
  "launch_context": "hackathon submission",
  "header_image_url": "https://...",
  "description": {
    "paragraph": "...",
    "who_for": "For solo founders, comics, and anyone preparing for a high-stakes performance.",
    "why_now": "Gemini multimodal video makes reference-grounded video-to-one-pager possible for the first time."
  },
  "features": [
    { "title": "...", "description": "...", "evidence": "https://..." }
  ],
  "links": {
    "product_url": "https://charismaster.com",
    "repo_url": "https://github.com/jennyruan/charismaster",
    "demo_url": "https://..."
  },
  "use_guidance": {
    "first_step": "...",
    "expected_output": "...",
    "power_tip": "..."
  },
  "built_story": {
    "stack": ["Gemini multimodal", "AI Studio Build", "Cloud Run"],
    "time": "3 hours, solo, at GDG Stanford × Red Bull Basement",
    "next": "Pilots with 3 accelerators."
  }
}
```

---

## 4. Iterative refinement (ALL THREE modes)

After the first generation, the output page shows a **Refine** panel above the
result. User can throw in more material and we re-call Gemini with the previous
output + new input as context.

### 4.1 Refine panel UI

Sticky at top of output page, collapsible.

```
┌────────────────────────────────────────────────────────────────┐
│ ✨ Refine this one-pager                                       │
├────────────────────────────────────────────────────────────────┤
│ Add a reference video:  [ paste URL ]   [ + upload ]           │
│                                                                │
│ Add a note:                                                    │
│ [ "Make the close more aggressive."                         ]  │
│ [ "Drop the third trap — it doesn't apply."                 ]  │
│ [ "Reference this YC pitch I love: https://youtube..."      ]  │
│                                                                │
│  [ Refine ]   (Generates a new version — previous is kept)     │
└────────────────────────────────────────────────────────────────┘
```

### 4.2 Refinement contract (what /api/refine receives)

```jsonc
{
  "previous_report_id": "uuid",
  "previous_output": { /* full Coach-Me or Save-Me object from §5 */ },
  "added_references": [
    { "type": "url", "value": "https://youtube.com/..." },
    { "type": "upload", "value": "data:video/mp4;base64,..." }
  ],
  "user_note": "Make the close more aggressive."
}
```

API returns a new full output object (same shape as the original) — frontend
re-renders. Each refinement produces a new version in the report history; user
can scroll back through versions.

### 4.3 Refinement Gemini prompt structure

Add to the bottom of the original system prompt:

```
The user has refined their input. Below is the previous output you generated,
plus the user's new references and notes. Produce a REVISED full output (same
schema) that:
- Honors the user's note literally.
- Integrates any new reference material into your analysis.
- Preserves the parts of the previous output the user did NOT critique.
- Keeps the user's voice (do not regress to generic phrasing).

<previous_output>{{json}}</previous_output>
<added_references>{{list}}</added_references>
<user_note>{{string}}</user_note>
```

### 4.4 Version history (light)

Sidebar on output page lists versions:

```
History
─────────
✓ v3 (current)  — "make close more aggressive"
  v2            — "add Sam Altman ref"
  v1            — original
```

Clicking a version restores it. Stored in-memory per session (no persistence
required for the demo).

---

## 5. JSON contract (what /api/analyze and /api/refine return)

All three modes return a single JSON object discriminated on `mode`. Coach Me
and Save Me schemas are shown below. Ship Me schema is in §3.5.8.

```jsonc
// Coach Me mode
{
  "mode": "coach_me",
  "version": 1,
  "skill": "YC Demo Day elevator pitch",
  "title": "How to master the YC Demo Day pitch",
  "subtitle": "Two minutes is enough. Yours just isn't.",
  "header_image_url": "https://...",
  "principles": [
    { "number": 1, "title": "...", "example": "...", "attribution": "Drew Houston, Dropbox 2007", "why_it_works": "..." }
  ],
  "traps": [
    { "title": "...", "why_it_fails": "...", "master_doing_it_right": "..." }
  ],
  "drills": [
    { "title": "...", "steps": ["...", "..."], "time_estimate": "5 min" }
  ],
  "watch_next": [
    { "title": "...", "url": "https://youtube.com/...", "why": "..." }
  ]
}

// Save Me mode
{
  "mode": "save_me",
  "version": 1,
  "title": "YBuffet → Stanford GDG, May 31 4 PM",
  "subtitle": "Land VC pitch meetings.",
  "time_limit_seconds": 60,
  "header_image_url": "https://...",
  "opening": { "line": "...", "delivery_hint": "...", "why_this_opens_strong": "..." },
  "beats": [
    { "timestamp": "0:15-0:30", "line": "...", "delivery_hint": "...", "safety_net": "..." }
  ],
  "close": { "line": "...", "ask": "...", "delivery_hint": "..." },
  "comebacks": [
    { "objection": "...", "response": "..." }
  ],
  "references": [ "https://...", "https://..." ]
}
```

Terminal A: paste this contract into the AI Studio Build prompt's `<schema>`
section. Use Zod (or AI Studio's structured-output equivalent) to enforce.

---

## 6. Print + share behavior (both modes)

### Print

`@media print` rules force single column, hide buttons + share strip + screen-
size toggle + refine panel, keep visual flourish. Page break controlled so each
artifact fits one US Letter page.

When the user picks the 🖨 Print variant, the layout snaps directly to the
print template (no media query needed; same DOM, different `:root` class).

### Share button

Single click → renders current screen-size variant of the one-pager DOM to PNG
(use `html-to-image` or server-side Puppeteer). Returns:
1. Public PNG URL.
2. Pre-composed tweet draft:
   - Save Me: `"I'm performing [<X>] tonight. CharisMaster wrote my one-pager. ↓"`
   - Coach Me: `"I'm learning [<X>]. CharisMaster made my how-to. ↓"`

PNG goes to Twitter / LinkedIn → drives traffic back to charismaster.com.

---

## 7. Quality bar (one-shot checklist for the demo)

- [ ] Save Me one-pager genuinely fits one printed page in 🖨 Print variant.
- [ ] Coach Me one-pager reads SPECIFIC — references and examples are real video moments, not chatbot generics.
- [ ] User's voice preserved in Save Me (verify against Jenny's past clip).
- [ ] **Ship Me on this repo produces a launch page that's actually shippable** (verify: paste this repo's URL + `docs/one-pager.md` + a fake AI chat transcript → produces a launch page that could go on Show HN as-is). This is the demo's recursive money shot — must work.
- [ ] Refinement works end-to-end across ALL THREE modes: paste new ref → click Refine → output changes meaningfully → version history shows v1 + v2.
- [ ] All 4 screen-size variants render correctly for all three modes.
- [ ] Share button works end-to-end: PNG + tweet draft per mode.
- [ ] No mock data, no Lorem, no placeholder names.

---

## 8. What this spec deliberately leaves OPEN to Terminal A

- Exact Tailwind classes (spec specifies treatment, not classes).
- Component decomposition (one big component vs many small).
- Whether the share PNG renders client-side (`html-to-image`) or server-side (Puppeteer on Cloud Run).
- Whether refinement runs as a streaming response or one-shot.
- Loading state copy and progress indicator design.

If A needs to deviate from anything above, append a note here + ping in
STATUS.md so all 4 terminals see it on next sync.
