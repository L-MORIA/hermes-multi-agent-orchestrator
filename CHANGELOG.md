# Changelog

## 1.0.0 (2026-07-07)

Initial release — Multi-Agent Orchestrator for Hermes Agent.

### Added
- 3 orchestration modes: Council (parallel), Pipeline (sequential), Hybrid
- 5 specialized roles: Architect, Planner, Coder, Synthesizer, Reviewer
- Model roster for OpenCode Zen free tier (Big Pickle, Deepseek, North Mini, Mimo, Nemotron)
- SKILL.md with orchestration logic and interaction patterns
- ARCHITECTURE.md with mermaid diagrams
- AGENTS.md for AI assistants
- Documentation in English and Russian
- Configuration template (config/models.yaml)

### Known issues
- Nemotron 3 Ultra may timeout on contexts >200 words — fallback to Deepseek
- Parallel sub-agents are isolated — dependent agents need a second round
- API model IDs for Big Pickle Med and North Mini Code need verification
