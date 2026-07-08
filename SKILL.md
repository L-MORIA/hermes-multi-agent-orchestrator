---
name: hermes-multi-agent-orchestrator
description: >-
  Multi-agent orchestration for Hermes Agent using OpenCode Zen free models.
  3 modes: Council (parallel), Pipeline (sequential), Hybrid.
  5 roles, 5 models: Big Pickle Med, Deepseek V4 Flash, Mimo V2.5,
  Nemotron 3 Ultra (Arbiter), North Mini Code.
  Tested and verified — see TEST_RESULTS.md.
version: 1.0.0
author: L-MORIA
tags: [multi-agent, orchestration, parallel, delegation, ensemble, council, pipeline]
platforms: [windows, linux, macos]
environments: [opencode-zen]
---

# Hermes Multi-Agent Orchestrator

> **Замени одного агента — командой агентов. Преврати последовательность — в параллель. Часы — в минуты.**

## Когда использовать

- Задача сложная и состоит из нескольких аспектов (исследование + анализ + код + ревью)
- Нужно сравнить несколько подходов / мнений / моделей
- Требуется глубокое исследование с разных углов
- Нужно сгенерировать код, потом его проверить, потом улучшить
- Пользователь говорит: «запусти нескольких агентов», «параллельно», «multi-agent»

## Доступные модели (OpenCode Zen — бесплатные)

| Модель (пикер) | Model ID (CLI) | Роль | Сильные стороны |
|----------------|----------------|------|----------------|
| **Big Pickle Med** | `opencode/big-pickle` | 🎯 **Architect** | Архитектура, креатив, мета-планирование |
| **Deepseek V4 Flash** | `opencode/deepseek-v4-flash-free` | 📋 **Planner** / 🔍 **Researcher** | Скорость, факты, логика |
| **Mimo V2.5** | `opencode/mimo-v2.5-free` | ✍️ **Synthesizer** | Креатив, генерация, описание |
| **Nemotron 3 Ultra** | `opencode/nemotron-3-ultra-free` | 👑 **Arbiter** 🔎 **Reviewer** | Глубокий анализ, синтез, валидация |
| **North Mini Code** | `opencode/north-mini-code-free` | 💻 **Coder** | Код, файловые операции |

> Все 5 моделей проверены в смок-тесте. Подробности — в TEST_RESULTS.md.

## 3 режима работы

### 🤖 Council (параллельный)

```
🎯 Architect (Big Pickle) → декомпозиция
    ↓
📋 Planner (Deepseek) → детальный план
    ↓
[🔍 Researcher A (Deepseek)] + [🔍 Researcher B (Mimo)] + [💻 Coder (North Mini)] — ПАРАЛЛЕЛЬНО
    ↓
✍️ Synthesizer (Mimo) → черновая сборка
    ↓
👑 Arbiter (Nemotron 3 Ultra) → финальный синтез, валидация
    ↓
Результат
```

**Когда:** исследование, сравнение, multi-perspective анализ  
**Скорость:** ~60% времени серийного подхода

### 🔧 Pipeline (последовательный)

```
🎯 Architect (Big Pickle) → структура
    → 📋 Planner (Deepseek) → план
    → 💻 Coder (North Mini) → реализация
    → ✍️ Synthesizer (Mimo) → оформление
    → 👑 Arbiter (Nemotron 3 Ultra) → ревью
    → Результат
```

**Когда:** code review, документы, перевод  
**Качество:** выше за счёт последовательной валидации

### 🎭 Hybrid (смешанный)

```
🎯 Architect → 📋 Planner
    → [🔍 Researcher] + [💻 Coder] — ПАРАЛЛЕЛЬНО
    → ✍️ Synthesizer → 👑 Arbiter
```

**Когда:** сложные задачи с research + code

## Процесс

### Шаг 0 — Активация

При получении задачи — **сразу ответить**, не начиная работу:

> 🐝 **Multi-Agent Orchestrator активирован**
> Задача декомпозируется, собираю команду агентов...

### Шаг 1 — Декомпозиция (Big Pickle Med)

Architect анализирует задачу, определяет:
- Режим (Council / Pipeline / Hybrid)
- Какие роли и модели нужны
- Количество агентов

### Шаг 2 — Объявление плана

Перед запуском показать таблицу:

```
📋 План работы:
┌──────────────┬────────────────────┬──────────────────┐
│ Роль         │ Модель             │ Model ID         │
├──────────────┼────────────────────┼──────────────────┤
│ 🎯 Architect │ Big Pickle Med     │ big-pickle       │
│ 🔍 Researcher│ Deepseek V4 Flash  │ deepseek-v4-...  │
│ 💻 Coder     │ North Mini Code    │ north-mini-code  │
│ ✍️ Synthesizer│ Mimo V2.5        │ mimo-v2.5-free   │
│ 👑 Arbiter   │ Nemotron 3 Ultra   │ nemotron-3-...   │
└──────────────┴────────────────────┴──────────────────┘
Режим: 🤖 Council
```

### Шаг 3 — Запуск через opencode CLI

Для реального diversity моделей использовать `opencode run` с флагом `--model`:

```bash
# Council: параллельный запуск с разными моделями
opencode run "задача 1" --model "opencode/big-pickle" &
opencode run "задача 2" --model "opencode/deepseek-v4-flash-free" &
opencode run "задача 3" --model "opencode/mimo-v2.5-free" &
wait

# Pipeline: последовательно с передачей контекста
opencode run "архитектура" --model "opencode/big-pickle" > result.md
opencode run "код" --model "opencode/north-mini-code-free" --context "$(cat result.md)"
```

Или использовать `scripts/run.sh`:
```bash
bash scripts/run.sh council \
  "Big Pickle Med:задача 1" \
  "Deepseek V4 Flash:задача 2" \
  "Mimo V2.5:задача 3"
```

### Шаг 4 — Синтез (Arbiter = Nemotron 3 Ultra)

Nemotron собирает результаты всех агентов и выдаёт:
1. Сводную таблицу / сравнение
2. Ключевые выводы (3-5)
3. Вердикт / рекомендации

### Шаг 5 — Сохранение и доставка

1. Сохранить `.md` файл
2. Отправить пользователю

## Питфоллы

1. **Nemotron 3 Ultra** может таймаутить на контекстах >5000 токенов — разбивать на части
2. **Параллельные агенты не видят друг друга** — зависимые задачи вторым раундом
3. **Объявлять активацию ДО работы** — иначе пользователь видит молчание
4. **Не выводить сырые результаты агентов** — всегда через арбитра
5. **`2>/dev/null` не использовать** в opencode run — stderr содержит важную инфу

## Примеры

### Пример 1: Сравнение фреймворков

```
User: "Сравни LangChain и CrewAI"
→ Council mode
→ 2 Researchers (Deepseek + Mimo) — параллельно
→ Arbiter (Nemotron) — синтез
```

### Пример 2: Code Pipeline

```
User: "Напиши парсер CSV"
→ Pipeline mode
→ Architect (Big Pickle) — дизайн
→ Coder (North Mini Code) — реализация
→ Arbiter (Nemotron) — ревью
```

### Пример 3: Исследование + код

```
User: "Исследуй Kafka и напиши пример producer/consumer"
→ Hybrid mode
→ Researcher (Deepseek) + Coder (North Mini) — параллельно
→ Arbiter (Nemotron) — синтез
```
