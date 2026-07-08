# AGENTS.md — Hermes Multi-Agent Orchestrator

## Project

Multi-agent orchestration for Hermes Agent using OpenCode Zen free models.
3 modes: Council (parallel), Pipeline (sequential), Hybrid.
5 models, 5 roles. Verified by smoke test.

## Model Roster

| Alias | Model ID | Default Role |
|-------|----------|-------------|
| `big-pickle` | `opencode/big-pickle` | 🎯 Architect |
| `deepseek` | `opencode/deepseek-v4-flash-free` | 📋 Planner / 🔍 Researcher |
| `mimo` | `opencode/mimo-v2.5-free` | ✍️ Synthesizer |
| `nemotron` | `opencode/nemotron-3-ultra-free` | 👑 Arbiter / 🔎 Reviewer |
| `north-mini` | `opencode/north-mini-code-free` | 💻 Coder |

## Critical Rules

1. **Nemotron 3 Ultra is the Arbiter** — final synthesis, NOT Mimo
2. **Announce activation FIRST** — before any `opencode run` call
3. **Parallel agents are blind** — dependent agents need a second round
4. **Nemotron may timeout** on >5000 token contexts → split input
5. **Always save output to .md** before delivering to user
6. **Synthesize via Arbiter** — never paste raw sub-agent output
7. **Use `2>&1` not `2>/dev/null`** in opencode run — stderr has important info

## Mode Routing

| Task type | Mode | Pattern |
|-----------|------|---------|
| Research / Compare | 🤖 Council | Parallel → Arbiter |
| Code / Document | 🔧 Pipeline | Sequential stages |
| Complex mixed | 🎭 Hybrid | Parallel first, then sequential |

## Execution Methods

### Via opencode CLI (recommended for diversity):

```bash
# Council: parallel with different models
opencode run "task A" --model "opencode/big-pickle" &
opencode run "task B" --model "opencode/deepseek-v4-flash-free" &
opencode run "task C" --model "opencode/mimo-v2.5-free" &
wait

# Arbiter synthesis
opencode run "synthesize: $results" --model "opencode/nemotron-3-ultra-free"
```

### Via scripts/run.sh:

```bash
bash scripts/run.sh council "Model:task" "Model:task"
bash scripts/run.sh pipeline "context" "Model:task" "Model:task"
```

## Output Format

Always use structured output via Arbiter:

```
## 📊 Execution Summary
| Agent | Model | Time | Status |

## 📋 Comparison Table (axes × frameworks)

## 🔍 Detailed Analysis

## 🏆 Verdict / Recommendations
```

## Companion Projects

- `hermes-superpowers-workflow` — full feature development lifecycle
- `hermes-llm-ensemble` — multi-model ensemble for single answers
- `kronos-signal` — MOEX/crypto forecasting

## Test Results

See TEST_RESULTS.md for full smoke test results with all 5 models.
