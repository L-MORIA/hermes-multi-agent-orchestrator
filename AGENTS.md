# AGENTS.md

## Project

**hermes-multi-agent-orchestrator** — Multi-agent orchestration skill for Hermes Agent using OpenCode Zen free models.

## Architecture

Three modes: Council (parallel), Pipeline (sequential), Hybrid (mixed).

### Model Roster (OpenCode Zen free)

| Alias | Model ID | Default Role |
|-------|----------|-------------|
| `big-pickle` | see provider picker | 🎯 Architect |
| `deepseek` | `deepseek-v4-flash` | 📋 Planner / 🔍 Researcher |
| `north-mini` | see provider picker | 💻 Coder |
| `mimo` | `minimax-m2.5` | ✍️ Synthesizer |
| `nemotron` | `nemotron-3-ultra` | 🔎 Reviewer |

### Critical Rules

1. **Announce activation FIRST** — before any `delegate_task` call
2. **Parallel agents are blind** — dependent agents need a second round
3. **Nemotron 3 Ultra** may timeout on prompts >200 words → fallback to Deepseek
4. **Always save output to .md** before delivering to user
5. **Synthesize results** — never paste raw sub-agent output
6. **Channel-aware delivery** — check channel before deciding how to send

### Mode Routing

| Task type | Mode | Pattern |
|-----------|------|---------|
| Research / Compare | 🤖 Council | Parallel → Synthesize |
| Code / Document | 🔧 Pipeline | Sequential stages |
| Complex mixed | 🎭 Hybrid | Parallel first, then sequential |

### Delegation Patterns

```python
# Council: all parallel
delegate_task(tasks=[
    {"goal": "Research aspect A..."},
    {"goal": "Research aspect B..."},
    {"goal": "Write code for..."},
])

# Pipeline: sequential with context
result = delegate_task(goal="Analyze...")
result = delegate_task(goal="Implement...", context=result)
result = delegate_task(goal="Review...", context=result)
```

### Output Format

Never output raw agent results. Always use:

```
## 📊 Execution Summary
| Agent | Model | Time | Status |

## Key Findings (3-5)

## Detailed Analysis (grouped by topic, not by agent)

## Recommendations
```

### Companion Skills

- `hermes-superpowers-workflow` — full feature development lifecycle
- `hermes-llm-ensemble` — multi-model ensemble for single answers
