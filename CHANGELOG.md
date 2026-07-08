# Changelog

## 1.0.0 (2026-07-08)

Initial release — Multi-Agent Orchestrator for Hermes Agent.

### Architecture
- 3 orchestration modes: Council (parallel), Pipeline (sequential), Hybrid
- 5 roles: Architect, Planner/Researcher, Coder, Synthesizer, Arbiter
- 5 OpenCode Zen free models: Big Pickle Med, Deepseek V4 Flash, Mimo V2.5, Nemotron 3 Ultra, North Mini Code

### Models (verified by smoke test)

| Model | Model ID | Role | Status |
|-------|----------|------|--------|
| Big Pickle Med | `opencode/big-pickle` | 🎯 Architect | ✅ |
| Deepseek V4 Flash | `opencode/deepseek-v4-flash-free` | 📋 Planner / 🔍 Researcher | ✅ |
| Mimo V2.5 | `opencode/mimo-v2.5-free` | ✍️ Synthesizer | ✅ |
| Nemotron 3 Ultra | `opencode/nemotron-3-ultra-free` | 👑 Arbiter / 🔎 Reviewer | ✅ |
| North Mini Code | `opencode/north-mini-code-free` | 💻 Coder | ✅ |

### Key findings from smoke test
- Nemotron 3 Ultra confirmed as best Arbiter (deep synthesis, 7 scenarios)
- Big Pickle Med excels at architecture/ meta-planning
- Mimo V2.5 handles Russian language well, good for synthesis
- North Mini Code writes real code and creates files
- `opencode run` requires message as positional arg, NOT `--prompt`
- `2>&1` must be used instead of `2>/dev/null` for opencode run

### Files
- SKILL.md, ARCHITECTURE.md, AGENTS.md, TEST_RESULTS.md
- README.md (EN), README.ru.md (RU)
- config/models.yaml — model roster
- scripts/run.sh — parallel Council + sequential Pipeline launcher
