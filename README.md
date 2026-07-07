# Hermes Multi-Agent Orchestrator

**Multi-agent orchestration for Hermes Agent using OpenCode Zen free models.**

Turn one agent into a team. Replace sequential work with parallelism. Use 5 specialized roles across 3 orchestration modes.

## Models (OpenCode Zen — Free Tier)

| Role | Model | Strength |
|------|-------|----------|
| 🎯 **Architect** | Big Pickle Med | Architecture, creativity, structure |
| 📋 **Planner / 🔍 Researcher** | Deepseek V4 Flash Free Max | Speed, balance, reliability |
| 💻 **Coder** | North Mini Code Free Med | Code, technical tasks |
| ✍️ **Synthesizer** | Mimo V2.5 Free Med | Generation, creativity, assembly |
| 🔎 **Reviewer** | Nemotron 3 Ultra Free Max | Deep analysis (⚠️ may timeout) |

## Modes

| Mode | Pattern | Use Case |
|------|---------|----------|
| 🤖 **Council** | All agents in parallel → Arbiter synthesizes | Research, comparison |
| 🔧 **Pipeline** | Sequential stages A → B → C → D | Code review, document writing |
| 🎭 **Hybrid** | Parallel first round, sequential second | Complex mixed tasks |

## Quick Start

This is a **Hermes Agent Skill**. It works through `delegate_task`.

### Example: Parallel Research (Council)

> User: *"Compare LangChain, CrewAI, and AutoGen"*

1. 🎯 Architect (Big Pickle) breaks down the task
2. 📋 Planner (Deepseek) creates detailed plan
3. 🔍 3 Researchers (Deepseek) search in parallel
4. ✍️ Synthesizer (Mimo) assembles final comparison
5. 🔎 Reviewer (Nemotron) does final check

### Example: Code Pipeline

> User: *"Review and fix this code"*

1. 🎯 Architect (Big Pickle) — analyze structure
2. 📋 Planner (Deepseek) — plan changes
3. 💻 Coder (North Mini Code) — implement fixes
4. 🔎 Reviewer (Nemotron) — final review

## Architecture

See [ARCHITECTURE.md](ARCHITECTURE.md) for full diagrams.

```
User → 🎯 Architect → 📋 Planner → [Parallel Agents] → ✍️ Synthesizer → 🔎 Reviewer → User
```

## Installation

Copy to Hermes skills directory:

```bash
cp -r hermes-multi-agent-orchestrator ~/.hermes/skills/
/reload-skills
```

## Files

| File | Description |
|------|-------------|
| `SKILL.md` | Main skill with orchestration logic |
| `ARCHITECTURE.md` | Architecture, diagrams, roles |
| `AGENTS.md` | AI agent instructions |
| `README.md` | This file |
| `README.ru.md` | Russian documentation |
| `config/models.yaml` | Model roster configuration |

## Pitfalls

- **Nemotron 3 Ultra** may timeout on long contexts → fallback to Deepseek
- **Parallel agents are isolated** — dependent work needs a second round
- **Announce before work** — tell the user activation is happening
- **Never paste raw agent output** — always synthesize
