# Build target: Google AI Studio (not hand-rolled Next.js)

> **Constraint:** the hackathon requires building through **Google AI Studio Build mode** (`aistudio.google.com/apps`), not by hand-coding a Next.js app and deploying it ourselves. Claude Code's job is to draft the optimal **one-shot build prompt** + supporting design assets that we paste into AI Studio. AI Studio handles scaffold, Gemini wiring, preview, and deploy.

Captured 2026-05-31, mid-hackathon. Jenny confirmed verbally.

---

## 1. What AI Studio Build mode is

- Natural-language → full app. You type a description; Studio generates a working web app (or native Android app) with Gemini already wired in.
- Iterate via **chat panel** (ask Studio to change styling, add features) or **Code tab** (edit generated code directly).
- One-click deploy to Cloud Run from the Studio UI.
- **AI Chips** in the input let you add capabilities without prose: image generation, Google Maps data, video, etc. Click the chip; don't describe it in text.
- Speech-to-text input is supported (useful for Jenny when she's tired of typing).

## 2. What this changes for Charismaster

- **No hand-written Next.js scaffold.** `package.json`, `app/layout.tsx`, `app/page.tsx`, `app/api/analyze/route.ts`, `lib/gemini.ts` — Studio generates all of it. Don't waste time writing these by hand.
- **No hand-written Cloud Run Dockerfile or gcloud deploy script.** Studio deploys.
- **Claude Code's deliverable shifts to:**
  1. One canonical AI Studio build prompt (`docs/ai-studio-prompt.md`)
  2. Reference corpus YouTube URLs (terminal D's `docs/reference-corpus.md`) pasted into the prompt as a literal list
  3. Report UI structure / fields (terminal C's design) pasted into the prompt as a layout spec
  4. Submission assets (one-pager, demo script, team intro, form answers) — unchanged
- **Iteration loop:** paste prompt → preview in Studio → if wrong, edit the prompt here in Claude Code (so all terminals can see the diff in git) → re-paste. Don't edit live in Studio's chat without mirroring the change back to `docs/ai-studio-prompt.md`.

## 3. Canonical prompt structure for AI Studio Build

Five-part anatomy (validated across community + Google docs):

```
[Role/Context] + [Goal/Outcome] + [Constraints] + [Tech stack & model] + [Output format]
```

Recommended conventions:

- **Be specific, not vague.** "Build a video analysis app that calls Gemini with the uploaded video + 3 reference YouTube URLs and returns a structured JSON report with these fields: …" beats "make an AI coaching app."
- **Pick one delimiter and stick to it.** XML tags (`<context>`, `<task>`, `<output>`) OR markdown headings. Don't mix.
- **Few-shot beats prose.** If a section of the report needs a specific tone, show one example of what good looks like inside the prompt — community + Google testing both confirm examples outperform instructions.
- **Define the model explicitly.** Jenny's example used `gemini-3-flash-preview`. Specify the model in the prompt; don't leave it to Studio's default.
- **Specify output format up front.** "Return a Next.js 15 app router project with TypeScript and Tailwind. Use Zod for the response schema. Persist nothing — everything in-memory per session."
- **Constraints prevent slop.** "Use Tailwind defaults only — no custom theme. Black text on white. No design system." This matches Charismaster's existing design rule (CLAUDE.md §3).
- **Reference assets go inline as data, not as instructions.** Paste the actual YouTube URL list into the prompt body, don't say "use the reference corpus."

## 4. Charismaster build-prompt skeleton (to fill in)

```
<role>
You are a senior full-stack engineer building a hackathon submission for
GDG Stanford × Red Bull Basement 2026-05-31. The product is "Charismaster":
an AI apprentice that watches a performer's video and compares their delivery
against canonical masters of their chosen form.
</role>

<goal>
Build a single-page Next.js 15 web app (app router, TypeScript) deployable
to Cloud Run. The app should:
1. Let the user upload a video file and pick a mode (Elevator Pitch, TED Talk,
   Stand-up, Sales Call).
2. POST to /api/analyze, which calls Gemini with the uploaded video + the 3
   YouTube reference URLs for the chosen mode, requesting a structured JSON
   report (see <schema> below).
3. Render /report/[id] with a side-by-side comparison: user's delivery vs
   reference masters, key moments, rewrites in user's voice, score.
</goal>

<constraints>
- Tailwind defaults only — no custom theme, black on white, real content over polish.
- No mock data. Empty states are fine. Never fabricate a user-facing example.
- No database. In-memory store keyed by report id is acceptable for the demo.
- Single page + /api/analyze route + /report/[id] page. No auth.
</constraints>

<tech>
- Next.js 15 app router, TypeScript
- @google/generative-ai SDK
- Model: gemini-3-flash-preview (or latest Gemini 2/3 video-capable model)
- Tailwind for styling
- Zod for the response schema
- Deploy: Cloud Run
</tech>

<reference-corpus>
[paste D's verified YouTube URLs here, per mode]
</reference-corpus>

<schema>
[paste the Report Zod schema here — fields: headline, scoreOutOf10,
hookStrength {score, note}, conviction {…}, pacing {…}, strengths[],
gaps[], keyMoments[{timestamp, observation, masterComparison}],
rewrites[{originalLine, rewrittenLine, why}], versusMasters]
</schema>

<report-ui>
[paste C's layout spec — header with score, 3-col stat grid, strengths/gaps,
key moments timeline, rewrites cards, "versus masters" narrative section,
reference corpus list]
</report-ui>

<output>
Generate the complete app. Include README with deploy instructions.
</output>
```

## 5. Per-terminal impact

| Terminal | Before | After |
|---|---|---|
| A (scaffold + Gemini) | Write Next.js skeleton, lib/gemini.ts, /api/analyze | Draft + iterate `docs/ai-studio-prompt.md`; stop writing app code |
| B (deploy + smoke) | Write gcloud deploy script + smoke test | Studio deploys. Repurpose to: post-deploy smoke test against the Studio-generated `*.run.app` URL. |
| C (report UI + docs) | Write `app/report/[id]/page.tsx` | Convert the page into a **layout spec** (markdown, component breakdown, fields, classnames) that gets pasted into the prompt. Submission docs unchanged. |
| D (reference corpus + form) | Verify URLs, draft form answers | Unchanged. URLs paste directly into prompt. |

## 6. Open questions to verify with Jenny

- Is the requirement strictly "must be built in AI Studio" or "must use Gemini + Google stack"? If the latter, hand-rolled Next.js + `@google/generative-ai` SDK is also valid and may be lower-risk for a polished demo.
- Does the hackathon submission form ask for the AI Studio app share link, or just the deployed URL + repo?

Flag any answers in `STATUS.md` so other terminals see them on next sync.

## Sources

- [Build apps in Google AI Studio — Gemini API docs](https://ai.google.dev/gemini-api/docs/aistudio-build-mode)
- [Google AI Studio quickstart](https://ai.google.dev/gemini-api/docs/ai-studio-quickstart)
- [Prompt design strategies — Gemini API](https://ai.google.dev/gemini-api/docs/prompting-strategies)
- [20 prompt templates for AI Studio (Naqash Khan, Medium)](https://medium.com/@naqash_khan/i-tested-google-ai-studio-and-created-20-developer-ready-prompt-templates-heres-what-i-learned-db7f3914c18e)
- [Google AI Studio at I/O 2026](https://blog.google/innovation-and-ai/technology/developers-tools/google-ai-studio-io-2026/)
- [Google AI Studio Build Tab guide (MindStudio)](https://www.mindstudio.ai/blog/google-ai-studio-build-tab-guide)
