# Hermes Multi-Agent Orchestrator

**Multi-agent orchestration for Hermes Agent using OpenCode Zen free models.**

Turn one agent into a team. Replace sequential work with parallelism.
3 modes, 5 specialized roles, 5 different models — each with a unique strength.
All models verified by smoke test.

## Models (OpenCode Zen — Free Tier)

| Role | Model | Model ID | Strength |
|------|-------|----------|----------|
| 🎯 **Architect** | Big Pickle Med | `opencode/big-pickle` | Architecture, creativity, meta-planning |
| 📋 **Planner / 🔍 Researcher** | Deepseek V4 Flash | `opencode/deepseek-v4-flash-free` | Speed, facts, logic |
| ✍️ **Synthesizer** | Mimo V2.5 | `opencode/mimo-v2.5-free` | Creativity, generation, description |
| 👑 **Arbiter / 🔎 Reviewer** | **Nemotron 3 Ultra** | `opencode/nemotron-3-ultra-free` | **Deep analysis, synthesis, validation** |
| 💻 **Coder** | North Mini Code | `opencode/north-mini-code-free` | Code, file operations |

> ⚠️ **Nemotron 3 Ultra is the Arbiter** — it performs the final synthesis of all agent results. Not Mimo, not Deepseek.

## Modes

| Mode | Pattern | Use Case |
|------|---------|----------|
| 🤖 **Council** | Parallel agents → Arbiter synthesizes | Research, comparison |
| 🔧 **Pipeline** | Sequential A → B → C → Arbiter | Code review, documents |
| 🎭 **Hybrid** | Parallel first, then sequential | Complex mixed tasks |

## Quick Start

### Council: Parallel Research

```bash
# 3 different models, running in parallel
opencode run "Research LangChain architecture" --model "opencode/deepseek-v4-flash-free" &
opencode run "Research CrewAI architecture" --model "opencode/mimo-v2.5-free" &
opencode run "Design comparison structure" --model "opencode/big-pickle" &
wait

# Arbiter synthesizes results
opencode run "Synthesize: $(cat results)" --model "opencode/nemotron-3-ultra-free"
```

### Pipeline: Code Generation

```bash
opencode run "Design CSV parser" --model "opencode/big-pickle" > arch.md
opencode run "Implement the parser" --model "opencode/north-mini-code-free" --context "$(cat arch.md)"
```

### Using scripts/run.sh

```bash
bash scripts/run.sh council \
  "Big Pickle Med:Design architecture" \
  "Deepseek V4 Flash:Research topic" \
  "Mimo V2.5:Research topic"

bash scripts/run.sh pipeline "context" \
  "Big Pickle Med:design" \
  "North Mini Code:code"
```

## Test Results

All 5 models tested. Full results in [TEST_RESULTS.md](TEST_RESULTS.md).

Key findings:
- **Nemotron 3 Ultra** → best Arbiter (deep synthesis, 7 comparison axes, 7 scenarios)
- **Big Pickle Med** → strong architect (10 evaluation axes, mermaid diagrams)
- **Deepseek V4 Flash** → deep factual research
- **Mimo V2.5** → good synthesizer (handles Russian, creative)
- **North Mini Code** → writes real code, creates files on disk

## Installation

```bash
git clone https://github.com/L-MORIA/hermes-multi-agent-orchestrator.git
cp -r hermes-multi-agent-orchestrator ~/.hermes/skills/
/reload-skills
```

## Files

| File | Description |
|------|-------------|
| `SKILL.md` | Main skill with orchestration logic |
| `ARCHITECTURE.md` | Architecture, mermaid diagrams, roles |
| `AGENTS.md` | AI agent instructions |
| `TEST_RESULTS.md` | Smoke test results |
| `config/models.yaml` | Model roster configuration |
| `scripts/run.sh` | Council and Pipeline launcher |

## Pitfalls

- **Nemotron 3 Ultra may timeout** on contexts >5000 tokens → split input
- **Parallel agents are isolated** — dependent work needs a second round
- **Announce before work** — tell the user activation is happening
- **Never paste raw agent output** — always synthesize via Arbiter
- **Use `2>&1` not `2>/dev/null`** in opencode run — stderr has important info
