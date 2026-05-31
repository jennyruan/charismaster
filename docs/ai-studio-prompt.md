# CharisMaster — Google AI Studio Build prompt

> One-shot prompt for `aistudio.google.com/apps`. Paste the **fenced block in §2**
> verbatim into AI Studio's Build mode input box. Don't paraphrase — the format
> is calibrated against the canonical 5-part anatomy (role / goal / constraints
> / tech / output) per `docs/ai-studio-build-rules.md`.
>
> Source of truth for the output layout: `docs/output-spec.md`.
> Source of truth for reference URLs: `docs/reference-corpus.md`.
> If either of those changes, regenerate this prompt — don't edit it in Studio's
> chat panel without mirroring the change back here so all four terminals see it
> in git.

Drafted 2026-05-31 by Terminal A.

---

## 1. How to use this prompt

1. Open `https://aistudio.google.com/apps`, click **Build**.
2. Paste the fenced block in §2 into the input box.
3. Optionally enable AI Chips before submitting: **Image generation** (for the
   Nano Banana flourish per mode). **Don't** describe Image-gen in prose —
   click the chip.
4. Hit submit. Studio scaffolds the Next.js app + Gemini wiring + Cloud Run
   deploy.
5. Iterate in Studio's chat panel OR by editing this file + re-pasting. Edits
   that survive past one demo session MUST come back into this file via git
   (per `CLAUDE.md` §0.5).

## 2. The prompt — paste this into AI Studio

```
<role>
You are a senior full-stack engineer building a hackathon submission for
GDG Stanford × Red Bull Basement, San Francisco, 2026-05-31 (cutoff 2:30 PM PT).
The product is CharisMaster: an AI apprentice for high-stakes performance and
launch communication, built on Gemini multimodal video understanding. Tagline:
"Coach me, save me, ship me. Land your message either way."
</role>

<goal>
Build a single-page Next.js 15 web app (app router, TypeScript) that ships
three distinct output artifacts from one Gemini multimodal engine, plus an
iterative refinement loop and a screen-size variant toggle. Deployable to
Cloud Run from this Studio session.

User flow:
1. Land on /, see a 3-card mode selector (Coach Me / Save Me / Ship Me).
2. Click a card → mode-specific input form (see <input-forms>).
3. Submit → POST /api/analyze → Gemini multimodal call with user inputs +
   the reference corpus URLs for the relevant mode → structured JSON output
   matching the mode's schema (see <schemas>).
4. Redirect to /report/[id] which renders a GRAPHICAL one-pager per the
   mode-specific layout (see <output-layouts>).
5. /report/[id] also exposes:
   - A screen-size toggle (📱 Phone / 📲 Tablet / 🖥 Desktop / 🖨 Print) that
     reflows the layout (see <screen-size-toggle>).
   - A Refine panel (see <refinement>) that lets the user add more reference
     material and free-text notes, POSTs to /api/refine, and re-renders.
   - A Share button that PNG-exports the currently-viewed variant and
     generates a pre-composed tweet draft per mode.
   - A version history sidebar (in-memory, session-scoped) listing previous
     refinement passes; clicking restores that version.
</goal>

<constraints>
- Tailwind defaults only. NO custom theme, NO design tokens, NO shadcn.
  Black text on white. Serif headings (`font-serif`), sans body.
- One accent color per mode: Coach Me = indigo, Save Me = amber,
  Ship Me = violet. Use Tailwind's default palette; no custom hex.
- NO mock data, NO Lorem ipsum, NO placeholder names like "Jane Smith".
  Empty states only. If a field is missing, render an empty-state component
  with explicit copy ("Add a reference video to populate this section").
- NO database. State is in-memory per session, keyed by a generated report
  id (UUID). Acceptable to lose state on server restart for the demo.
- NO authentication. Single public deploy.
- NO over-engineering. Three pages total: `/`, `/report/[id]`, plus the two
  API routes. One shared layout. Component decomposition is up to you, but
  keep total file count under 20.
- Footer on every output page: "Made with CharisMaster — charismaster.com"
  + the Share button.
- All UI copy is English. Tone is direct, founder-voiced — never marketing
  fluff. "Generate my Save Me one-pager" not "✨ Craft your AI experience".
</constraints>

<tech>
- Next.js 15 app router, TypeScript, React Server Components where possible.
- Tailwind CSS for styling (default config).
- Zod for response-schema validation and TypeScript inference.
- `@google/generative-ai` SDK for Gemini calls.
- Model for text + multimodal video analysis: `gemini-3-flash-preview`.
  (If video-input quality is poor, swap to `gemini-3-pro` for /api/analyze
  but keep flash for /api/refine to stay fast.)
- Image generation for Nano Banana flourishes: `gemini-3-flash-image-preview`
  (a.k.a. "Nano Banana 2"). Generate ONCE per report; cache the image URL on
  the report object.
- PNG export for Share: `html-to-image` client-side. Fall back to a
  server-side Puppeteer route if the client-side render is missing fonts.
- Environment: `GEMINI_API_KEY` from `process.env`. Provide a `.env.example`.
- Deploy: Cloud Run via Studio's built-in deploy button. No hand-written
  Dockerfile needed.
</tech>

<input-forms>
Each mode's form is rendered on `/` after the user clicks its card. The
selector card UI:

- 3 cards in a row on desktop, stacked on mobile.
- Each card: emoji + mode name + 1-line user intent + 1-line output
  description, on a white card with subtle shadow.
- "🎓 COACH ME — I want to get better at this over time. (Reusable how-to.)"
- "🎯 SAVE ME — I have a pitch/talk/set tomorrow. (Single-use cheat sheet.)"
- "🚀 SHIP ME — I built a thing. Help me launch it. (Shareable launch page.)"

Per-mode form fields:

Coach Me:
- text: "What skill do you want to master?"
- radio: form (Pitch / TED talk / Stand-up / Sales call) — optional
- url or file upload: "Paste a past clip of you trying this skill" — optional
- submit: "Generate my Coach Me one-pager"

Save Me:
- text: "What are you performing, and when?"
- text: "What outcome do you want?"
- textarea + image upload: "Audience — who's in the room? (paste names,
  bios, or a screenshot)" — Gemini OCRs uploaded images.
- segmented control: "Time limit?" (30s / 60s / 2 min / 5 min / custom)
- url or file upload: "Paste a past performance of yours" — optional
- radio: form (Pitch / TED talk / Stand-up / Sales call) — optional
- submit: "Generate my Save Me one-pager"

Ship Me:
- text: "What did you build? (give it a working name)"
- textarea + file upload: "📄 Design docs / plans / README" (.md, .pdf, .txt)
- textarea + file upload: "💬 AI chat history (your build conversation)"
  (.json, .md)
- url: "📦 Code repo (public GitHub URL — Gemini reads the README + file tree)"
- url: "🔗 Live product link"
- textarea: "✍️ Anything else you want to say about it"
- text: "Who's the builder?" (default: "anonymous solo builder")
- radio: launch context (Show HN / Product Hunt / hackathon submission /
  Twitter launch / investor email / personal portfolio) — optional
- submit: "Generate my Ship Me one-pager"
</input-forms>

<reference-corpus>
Hardcode this corpus into `lib/reference-corpus.ts`. The relevant 3 URLs for
the selected form are passed to Gemini as multimodal video inputs (Gemini's
File API ingests public YouTube URLs directly — no pre-download).

Elevator Pitch (YC Demo Day):
- https://www.youtube.com/watch?v=PXHvt_0eoZ4
- https://www.youtube.com/watch?v=-OBE3gRGGz4
- https://www.youtube.com/watch?v=U-cm72TLBm4

TED-style Talk:
- https://www.youtube.com/watch?v=iCvmsMzlF7o  (Brené Brown — Vulnerability)
- https://www.youtube.com/watch?v=u4ZoJKF_VuA  (Simon Sinek — Start With Why)
- https://www.youtube.com/watch?v=c0KYU2j0TM4  (Susan Cain — Introverts)

Stand-up Set:
- https://www.youtube.com/watch?v=dTi6efpPSZ0  (Mulaney — Salt & Pepper Diner)
- https://www.youtube.com/watch?v=UZpu9OW1O-U  (Birbiglia — David O. Russell)
- https://www.youtube.com/watch?v=7sypknCMSFU  (Birbiglia — Rubbed Wrong Way)

Sales Call: empty for v0. Render empty-state in the form.

For Ship Me mode, the "reference corpus" is the user's own raw materials
(design docs, chat history, repo, live link, notes) — there is no canonical
public corpus. Pass user inputs straight to Gemini.
</reference-corpus>

<schemas>
All three modes return one JSON object discriminated on `mode`. Validate with
Zod and use the inferred TS types throughout.

```ts
// Coach Me
const CoachMeSchema = z.object({
  mode: z.literal("coach_me"),
  version: z.number().int().positive(),
  skill: z.string(),
  title: z.string(),               // "How to master <skill>"
  subtitle: z.string(),            // pull-quote from a master
  header_image_url: z.string().url(),
  principles: z.array(z.object({
    number: z.number().int(),
    title: z.string(),
    example: z.string(),
    attribution: z.string(),        // e.g. "Drew Houston, Dropbox 2007"
    why_it_works: z.string(),
  })).length(3),
  traps: z.array(z.object({
    title: z.string(),
    why_it_fails: z.string(),
    master_doing_it_right: z.string(),
  })).length(3),
  drills: z.array(z.object({
    title: z.string(),
    steps: z.array(z.string()),
    time_estimate: z.string(),      // "5 min"
  })).length(3),
  watch_next: z.array(z.object({
    title: z.string(),
    url: z.string().url(),
    why: z.string(),
  })).min(2).max(3),
});

// Save Me
const SaveMeSchema = z.object({
  mode: z.literal("save_me"),
  version: z.number().int().positive(),
  title: z.string(),
  subtitle: z.string(),
  time_limit_seconds: z.number().int().positive(),
  header_image_url: z.string().url(),
  opening: z.object({
    line: z.string(),
    delivery_hint: z.string(),
    why_this_opens_strong: z.string(),
  }),
  beats: z.array(z.object({
    timestamp: z.string(),          // "0:15-0:30"
    line: z.string(),
    delivery_hint: z.string(),
    safety_net: z.string(),         // 1-line backup if they freeze
  })).min(3).max(5),
  close: z.object({
    line: z.string(),
    ask: z.string(),
    delivery_hint: z.string(),
  }),
  comebacks: z.array(z.object({
    objection: z.string(),
    response: z.string(),
  })).min(2).max(3),
  references: z.array(z.string().url()),
});

// Ship Me
const ShipMeSchema = z.object({
  mode: z.literal("ship_me"),
  version: z.number().int().positive(),
  product_name: z.string(),
  tagline: z.string(),
  builder_credit: z.string(),
  launch_context: z.string(),       // "hackathon submission" / "Show HN" / etc.
  header_image_url: z.string().url(),
  description: z.object({
    paragraph: z.string(),
    who_for: z.string(),
    why_now: z.string(),
  }),
  features: z.array(z.object({
    title: z.string(),               // verb-led
    description: z.string(),
    evidence: z.string().url().optional(),
  })).min(3).max(6),
  links: z.object({
    product_url: z.string().url().optional(),
    repo_url: z.string().url().optional(),
    demo_url: z.string().url().optional(),
  }),
  use_guidance: z.object({
    first_step: z.string(),
    expected_output: z.string(),
    power_tip: z.string(),
  }),
  built_story: z.object({
    stack: z.array(z.string()),
    time: z.string(),
    next: z.string(),
  }).optional(),
});

const ReportSchema = z.discriminatedUnion("mode", [
  CoachMeSchema, SaveMeSchema, ShipMeSchema,
]);
```

Use Gemini's structured-output mode (`responseSchema` + `responseMimeType:
"application/json"`) and pass the Zod-derived JSON Schema. Reject anything
that fails Zod parse — surface the error in the empty-state UI, never
fabricate.
</schemas>

<output-layouts>
All three modes render a graphical one-pager with:
- Title block (mode-specific — see below).
- Header illustration in the top-right (Nano Banana, see <visual-flourish>),
  hidden on phone variant.
- Mode-specific body sections.
- Footer strip: generated date, mode label, "Made with CharisMaster —
  charismaster.com", Share button.

Coach Me sections (in order):
1. Title block: `How to master <skill>` (text-3xl font-serif font-bold),
   subtitle pull-quote (italic gray-600), meta strip (text-xs uppercase
   tracking-wide gray-500).
2. "The 3 things masters do" — 3 cards, each with big indigo numeral
   (text-5xl font-serif text-indigo-600), title, example w/ attribution,
   why-it-works line.
3. "3 traps to avoid" — small ⚠️ glyph per trap, title, why-it-fails,
   master-doing-it-right.
4. "Drills you can do today" — 3 cards row, time-estimate badge top-right,
   checkbox-style step list.
5. "Watch next" — 2-3 reference videos, each with title, URL, 1-line why.

Save Me sections (in order):
1. Title block: occasion + date (text-3xl), desired outcome (text-base),
   time-limit pill (amber-100 bg).
2. "Your opening (15s)" — large monospace quote (text-xl indented),
   delivery hint (text-xs uppercase amber-700), why-it-opens-strong.
3. "Your beats" — vertical timeline, mono timestamps on left rail
   (amber-700), beat line (text-base font-medium), delivery hint,
   safety_net (text-xs gray-500 italic). Connecting line between beats.
   Same layout across all screen-size variants.
4. "Your close + ask" — large quote, bold indigo ask, delivery hint.
5. "If they push back on…" — 2-3 objection cards (sidebar on desktop/tablet,
   stacked on phone).

Ship Me sections (in order):
1. Title block: product name (text-4xl), tagline (text-lg italic),
   builder credit (text-sm gray-600), launch-context pill (violet-100 bg).
2. "What it is" — paragraph, who-for, why-now (text-xs italic).
3. "Features" — 3-6 cards, verb-led title, 1-sentence description,
   optional evidence link. Row of 3 on desktop, 2 on tablet, 1 on phone.
4. "Try it" — links section with big indigo "Try the product" button,
   secondary repo + demo buttons, first_step + expected_output +
   power_tip in a guidance block.
5. "How it was built" — optional, renders only if `built_story` present.
   Stack as font-mono chip list, time as italic, next as plain text.
</output-layouts>

<screen-size-toggle>
Above the rendered one-pager on /report/[id], a 4-button toggle:
[ 📱 Phone ] [ 📲 Tablet ] [ 🖥 Desktop ] [ 🖨 Print ]

Implementation: a single React state variable controls a `data-variant` attr
on the outermost <main>. Tailwind container queries OR a forced viewport
class drive the layout. Whichever AI Studio scaffolds cleanly — pick one and
be consistent.

Width targets:
- 📱 Phone: 375px, single column, big tap targets, action buttons sticky
  bottom.
- 📲 Tablet: 768px, two columns where called out.
- 🖥 Desktop: 1280px, full multi-column, generous whitespace.
- 🖨 Print: US Letter (816×1056 @ 96dpi), hides toggle + refine panel +
  share strip, keeps the header illustration. Use a `.print-variant` class
  that applies print-equivalent styles whether the user is actually
  printing or just previewing.

The Share button captures whatever variant is currently displayed.
</screen-size-toggle>

<refinement>
Sticky-collapsible panel at the top of /report/[id]:

- "✨ Refine this one-pager"
- Field: "Add a reference video" — URL input + upload button.
- Field: "Add a note" — textarea, placeholder examples like "Make the close
  more aggressive." / "Drop the third trap." / "Reference this YC pitch I
  love: <url>".
- Button: "Refine" — POSTs to /api/refine with:
  { previous_report_id, previous_output, added_references, user_note }
- Response: a new report object (same Zod-validated schema). Frontend
  renders it as a new version and appends it to the version-history
  sidebar.

Version history sidebar (in-memory, session-scoped):
- List of versions newest-first ("v3 (current) — make close more
  aggressive", "v2 — add Sam Altman ref", "v1 — original").
- Click a version → restore it as the current display.
- Persisted in a React context keyed by the original report id, lost on
  refresh — that's acceptable for the demo.

/api/refine prompt: append the user's note + new references to the
ORIGINAL system prompt for the mode, then add:

"The user has refined their input. Below is the previous output you
generated, plus the user's new references and notes. Produce a REVISED
full output (same schema) that:
- Honors the user's note literally.
- Integrates any new reference material into your analysis.
- Preserves parts of the previous output the user did NOT critique.
- Keeps the user's voice — do not regress to generic phrasing.

<previous_output>{json}</previous_output>
<added_references>{list}</added_references>
<user_note>{string}</user_note>"
</refinement>

<visual-flourish>
Each report has ONE header illustration generated via Gemini image gen
(Nano Banana). Generate once per report, cache the URL on the report
object, reuse across screen-size variants and refinements (don't regenerate
on refine — keeps visual continuity).

Coach Me prompt: "Hand-drawn ink-style illustration, black lines on white,
sketchnote aesthetic, single subject: a confident speaker at a wooden
lectern, gesturing outward, simple background. No text. Square aspect."

Save Me prompt: "Hand-drawn ink-style illustration, black lines on white,
sketchnote aesthetic: a vertical timeline with 4 numbered circles connected
by a curved line, each circle slightly different size to suggest rhythm.
No text labels. Tall narrow aspect."

Ship Me prompt: "Hand-drawn ink-style illustration, black lines on white,
sketchnote aesthetic, single subject: a paper airplane mid-launch with a
small trailing arc of motion lines suggesting forward momentum. No text.
Square aspect."

Always black ink on white, always sketchnote aesthetic, never photographic,
never colored. Consistency across modes matters more than uniqueness per
report.
</visual-flourish>

<share>
Single click → renders current screen-size variant of the one-pager DOM to
PNG via `html-to-image`. Returns:
1. A blob URL the user can right-click → save.
2. A pre-composed tweet draft per mode (opens in new tab to Twitter
   intent URL):
   - Coach Me: "I'm learning [skill]. CharisMaster made my how-to. ↓"
   - Save Me: "I'm performing [occasion] tonight. CharisMaster wrote my
     one-pager. ↓"
   - Ship Me: "I built [product_name]. Launch page made with CharisMaster. ↓"

PNG export must match the currently-viewed variant exactly.
</share>

<output>
Generate the complete Next.js 15 app. Include:
- All routes: /, /report/[id], /api/analyze (POST), /api/refine (POST).
- All components needed for the 3 mode forms + 3 output layouts + screen-
  size toggle + refine panel + version history sidebar + share button.
- `lib/gemini.ts` SDK wrapper with `analyze()` and `refine()` functions.
- `lib/schema.ts` with the Zod schemas above.
- `lib/reference-corpus.ts` with the hardcoded URLs above.
- `lib/report-store.ts` in-memory store keyed by UUID (Map).
- `.env.example` with `GEMINI_API_KEY=` placeholder.
- A short README with: setup (pnpm install, set GEMINI_API_KEY, pnpm dev),
  deploy (use Studio's deploy button), and the 3-mode quickstart.
- No tests (hackathon scope).
</output>
```

## 3. Post-paste iteration tips

- **First render will be wrong somewhere.** Use Studio's chat panel for
  one-off tweaks ("the Save Me beats timeline is too cramped on tablet").
  If the tweak is structural or you'll want it in a second session, mirror
  the change back to this file and re-paste.
- **Video ingestion latency**: Gemini multimodal calls with 3 YouTube URLs
  take 30-90s. The frontend should show a loading state with copy like
  "Gemini is watching your video + 3 reference clips. Hang on."
- **Token budget for /api/analyze**: 3 YouTube videos + user upload + system
  prompt + schema can push past 500K tokens. If Studio's generated app
  crashes on large payloads, ask it to "switch /api/analyze to use the
  Files API and upload videos before the generation call."
- **Common failure mode**: Studio may scaffold a custom Tailwind theme even
  though we said NO. If it does, ask: "Remove the custom Tailwind theme.
  Use Tailwind's default config and palette only. Keep accent colors as
  Tailwind's built-in indigo, amber, violet."
- **Ship Me self-test (quality bar §7)**: paste this repo's URL +
  `docs/one-pager.md` + a short fake chat transcript into Ship Me mode.
  Output should be Show-HN-ready. If it isn't, the prompt's `<schemas>` or
  `<output-layouts>` for Ship Me needs work.

## 4. Open questions to verify in Studio

- Does Studio's generated app actually call Gemini with YouTube URLs, or
  does it transcribe first? Verify by reading the generated `lib/gemini.ts`
  before deploy.
- Does Image gen via Nano Banana work inside Studio's scaffolded app, or do
  we need to call it from a server route? If server-only, the prompt needs
  an explicit `/api/header-image?mode=` route.
- Does Studio's deploy include `GEMINI_API_KEY` from the project
  environment, or do we need to set it manually in the Cloud Run console?

Flag answers in `STATUS.md` as you learn them so B/C/D see them on sync.

---

## 5. Iteration log (post initial paste)

The §2 prompt is the v1 build. Below are subsequent iterations Jenny made via
Studio's chat panel. These are RECORDED here so:
- If Studio's session is lost, we can replay them in order to rebuild.
- Other terminals can see the current state of the app without re-asking Jenny.

Append new iterations to the bottom. Each entry: timestamp, scope, the literal
prompt Jenny pasted, and a one-line outcome note (filled in after Studio
finishes that iteration).

### 5.1 — 2026-05-31 ~13:50 PT — Save Me universal-input flow

**Scope:** Save Me page only. Replace the multi-field form with a single
universal-input zone, auto-extract structured fields via Gemini, surface
extracted context as editable chips + a multi-select "task list" of work
CharisMaster will do, then generate.

**Prompt pasted into Studio chat panel:**

```
On the Save Me page only, replace the current multi-field form with a two-step universal-input flow. Do NOT change Coach Me or Ship Me.

STEP 1 — Universal input
One large drag-and-drop input zone. Accepts: free text, URLs, images, files (PDF, .pptx, .md, .txt). Single primary button below: "Extract & plan".

On click, POST to a NEW route /api/extract-tasks with the dumped blob (text + uploads multipart). The route calls Gemini multimodal (gemini-3-flash-preview) and returns:
{
  extracted_context: {
    occasion, when, time_limit_seconds, outcome,
    audience: [{name, bio}], past_performance_url,
    form: "pitch"|"ted_talk"|"standup"|"sales_call",
    slides_summary
  },
  suggested_tasks: [{ id, label, why, default_selected: boolean }]
}
Any field Gemini cannot extract from the blob comes back as null/empty — never hallucinated.

STEP 2 — Review & select
Replace the input zone with two stacked panels:
(A) Extracted context as editable chips ("⏱ 60s", "🎯 VC meetings", "👥 Sarah Park + 2 more", "🎤 Pitch"). Click to edit inline. "Not detected: + Add field" row.
(B) Suggested tasks as a checkbox list. Always-on (pre-checked): draft 15s opening, outline 3-5 timed beats, write close+ask, prepare 2-3 comebacks. Conditional: research panelists (if names), slide talking points (if deck), Q&A prep (if agenda), pre-performance ritual (default off).

Two buttons: Secondary "Re-extract with a note", Primary "GENERATE MY SAVE ME ONE-PAGER" → POST /api/analyze with { extracted_context, selected_task_ids }. Save Me system prompt includes ONLY sections for selected tasks; Zod schema branches accordingly.

Keep existing Save Me styling, screen-size toggle, Refine panel, Share button, version history. No mock data — empty state with original blob + "Try again" if extraction returns nothing.
```

**Outcome:** Superseded before Studio finished — Jenny pivoted to the
Project + multi-task architecture in §5.2 instead. This prompt was NOT
pasted on its own.

### 5.2 — 2026-05-31 ~14:00 PT — Project entity + mode workspaces + per-output refine

**Scope:** Full app refactor. Introduce Project entity that owns multimodal
context + an AI-generated user-editable task list. Each mode page accepts
BOTH ad-hoc inputs (existing per-mode quick-input forms, kept verbatim) AND
imported tasks from any project. Each input source generates one output
card in a grid; parallel Gemini calls. Per-card refine + per-card version
history + per-card screen-size toggle + per-card share. /report/[id] route
removed; outputs live inside the mode workspace.

**Prompt pasted into Studio chat panel** (the full refactor brief):

```
Major refactor — introduce a Project entity that owns context + tasks, but make every mode page work standalone OR with imported project tasks. Keep all existing visual styling (Tailwind defaults, mode accent colors, screen-size toggle, share button) — change only the data flow and page structure.

[Data model: Project { id, name, context: { text, links, files }, tasks, createdAt }; Task { id, projectId, label, description, sourceRefs, createdBy }; InputSource = { kind:"adhoc", mode, formData } | { kind:"task", projectId, taskId }; Output { id, mode, inputSource, status, versions:[{id, payload, refinePrompt, generatedAt}], currentVersionId }.

Routes: / (home: projects + 3-card mode launcher); /project/[id] (context editor + task list + mode launcher); /coach-me, /save-me, /ship-me (mode workspaces with input-sources panel + outputs grid).

Mode workspace: "🆕 Add ad-hoc input" (opens existing per-mode quick-input form) + "📥 Import task from project" (project dropdown → task multi-select). Each becomes a chip in pending list. "Generate N outputs" → parallel Gemini calls → cards stream in. Each card has inline refine textarea + version dropdown + per-card screen-size toggle + per-card share.

API: POST /api/project, POST /api/project/[id]/context, POST /api/project/[id]/extract-tasks (Gemini multimodal → suggested tasks merged with user tasks), POST /api/project/[id]/task, POST /api/generate (body: { mode, inputSources }, Promise.all → N parallel Gemini calls), POST /api/refine (per-output, appends version).

Preserve: 3 mode-specific output layouts + Zod schemas, screen-size toggle (now per-card), share (per-card), per-mode quick-input forms (now the "ad-hoc" option), Tailwind defaults, mode accent colors, "Made with CharisMaster" footer, no mock data.

Remove: /report/[id] route, global Refine panel, global version history sidebar.

Task extraction prompt: suggest 4-8 discrete tasks specific to this project's context (not generic). If referenced input is missing, surface it explicitly.

Keep file count under 30. In-memory store, session-scoped.]

Full text in docs/ai-studio-prompt.md §2 + §5.2 of this file.
```

(The literal brief Jenny pasted is roughly twice this long — the full text
is preserved in chat / commit `de53248` follow-up. The bracketed summary
above is a paste-back-into-Studio-able compression for replay.)

**Outcome:** PENDING — Studio is building as of 2026-05-31 ~14:00 PT.
Demo script (`docs/demo-script.md`) is calibrated to the v1 single-shot
flow; will need a rewrite if v2 lands successfully.

