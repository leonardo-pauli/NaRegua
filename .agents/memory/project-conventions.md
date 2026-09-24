---
type: project
created: 2026-05-25
updated: 2026-07-12
---

# Project Conventions

## Git Workflow
- Always create a new dedicated branch for major code changes.
- Branch name format should follow: `feature/[task-slug]` or `fix/[bug-slug]`.

## Supported AI platforms (AG Kit)
- AG Kit **only supports Gemini CLI and Google Antigravity**.
- Do not claim compatibility with Claude Code, Cursor, Copilot, Windsurf, or other assistants unless the user explicitly expands scope.
- Copy on the website, docs, FAQ, README, and marketing should describe AG Kit as a toolkit for Gemini CLI / Antigravity-style agent setups.

## Extracted AG Kit Tooling for Barber Flow (Flutter App)
- **Primary Agent**: Always utilize `mobile-developer` and the `mobile-design` skill for building UI/UX and feature logic. Ignore Web/Backend skills from AG Kit.
- **Workflow Commands**: Use `/brainstorm` for new feature exploration and `/plan` for step-by-step task breakdown.
- **Quality & Debugging**: Enforce `clean-code` standards globally. When debugging, rely on `systematic-debugging`. Always `verify-changes` by proving code works via execution, not just inspection.
