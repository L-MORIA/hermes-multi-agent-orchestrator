# Hermes Multi-Agent Orchestrator — Architecture

## System Architecture

```mermaid
flowchart TD
    subgraph User["👤 User Request"]
        TASK[Complex Task]
    end

    subgraph Orchestrator["🐝 Orchestrator (Hermes Agent)"]
        ARCH[🎯 Architect<br/>Big Pickle Med<br/>→ декомпозиция]
        PLAN[📋 Planner<br/>Deepseek V4 Flash<br/>→ детальный план]
    end

    subgraph Council["🤖 Council Mode — Parallel"]
        R1[🔍 Researcher A<br/>Deepseek V4 Flash]
        R2[🔍 Researcher B<br/>Deepseek V4 Flash]
        CD[💻 Coder<br/>North Mini Code]
        WR[✍️ Writer<br/>Mimo V2.5]
    end

    subgraph Synthesis["✍️ Synthesis"]
        SYN[✍️ Synthesizer<br/>Mimo V2.5<br/>→ сборка результатов]
    end

    subgraph Review["🔎 Review"]
        REV[🔎 Reviewer<br/>Nemotron 3 Ultra<br/>→ финальная проверка]
    end

    TASK --> ARCH
    ARCH --> PLAN

    PLAN --> Council
    
    Council --> SYN
    SYN --> REV
    REV --> RESULT[✅ Final Response]
```

## Pipeline Mode

```mermaid
flowchart LR
    A[🎯 Architect<br/>Big Pickle] --> P[📋 Planner<br/>Deepseek]
    P --> C[💻 Coder<br/>North Mini Code]
    C --> S[✍️ Synthesizer<br/>Mimo]
    S --> R[🔎 Reviewer<br/>Nemotron]
    R --> DONE[✅ Done]
```

## Hybrid Mode

```mermaid
flowchart TD
    A[🎯 Architect<br/>Big Pickle] --> P[📋 Planner<br/>Deepseek]
    P --> PARA{Parallel Round}
    PARA --> R1[🔍 Researcher<br/>Deepseek]
    PARA --> C1[💻 Coder<br/>North Mini Code]
    R1 --> SYN[✍️ Synthesizer<br/>Mimo]
    C1 --> SYN
    SYN --> REV[🔎 Reviewer<br/>Nemotron]
    REV --> DONE[✅ Done]
```

## Model Roster

| Псевдоним | API Model ID | Роль по умолчанию | Сильные стороны | Лимитации |
|-----------|-------------|-------------------|----------------|-----------|
| `big-pickle` | ? | 🎯 Architect | Архитектура, креатив, мета-планирование | Не тестировался на длинных промптах |
| `deepseek` | `deepseek-v4-flash` | 📋 Planner / 🔍 Researcher / 👑 Arbiter | Скорость, balanced, надёжность | Базовая модель |
| `north-mini` | ? | 💻 Coder | Код, технические задачи | Специализирован, вне кода слабее |
| `mimo` | `minimax-m2.5` | ✍️ Synthesizer | Креативность, текст, генерация | Не для кода |
| `nemotron` | `nemotron-3-ultra` | 🔎 Reviewer | Глубокий анализ, рассуждения | **Таймауты на >200 слов**, нестабилен |

## Mode Routing Logic

```
Задача получена
  │
  ├── Research / Comparison / Multi-perspective
  │   └── 🤖 Council — параллельные исследователи → синтез
  │
  ├── Code / Document / Pipeline
  │   └── 🔧 Pipeline — Architect → Planner → Coder → Synthesizer → Reviewer
  │
  └── Complex (research + code + analysis)
      └── 🎭 Hybrid — сначала параллель, потом последовательно
```

## Delegation Flow

```python
# Council mode
tasks = [
    {"goal": "Исследуй аспект A...", "context": "..."},
    {"goal": "Исследуй аспект B...", "context": "..."},
    {"goal": "Исследуй аспект C...", "context": "..."},
]
delegate_task(tasks=tasks)

# Pipeline mode
result1 = delegate_task(goal="Architect: разбей задачу...")
result2 = delegate_task(goal="Coder: реализуй...", context=result1)
result3 = delegate_task(goal="Reviewer: проверь...", context=result2)
```

## Directory Structure

```
hermes-multi-agent-orchestrator/
├── SKILL.md              # Основной скилл (EN инструкции)
├── ARCHITECTURE.md       # Архитектура, схемы, роли  
├── AGENTS.md             # Инструкции для AI-агентов
├── CHANGELOG.md          # История версий
├── README.md             # Документация EN
├── README.ru.md          # Документация RU
├── config/
│   └── models.yaml       # Модели и роли
└── scripts/
    └── plan.sh           # Шаблон объявления плана
```

## Pitfalls

1. **Nemotron timeout** — при длинных контекстах заменять на Deepseek
2. **Sub-agents blind** — параллельные агенты не видят друг друга
3. **Activation first** — объявлять запуск до первой delegate_task
4. **Synthesize output** — никогда не выводить сырые результаты агентов
5. **Channel-aware delivery** — проверять куда отправлять результат
