---
name: hermes-multi-agent-orchestrator
description: >-
  Multi-agent orchestration for Hermes Agent using OpenCode Zen free models.
  5 proven patterns: Council (parallel), Pipeline (sequential), Hybrid.
  Roles: Architect (Big Pickle Med), Planner/Researcher (Deepseek V4 Flash),
  Coder (North Mini Code), Synthesizer (Mimo V2.5), Reviewer (Nemotron 3 Ultra).
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

| Модель (пикер) | Модель (API) | Роль | Сильные стороны |
|----------------|--------------|------|----------------|
| **Big Pickle Med** | ? | 🎯 **Architect** | Архитектура, креатив, структура решения |
| **Deepseek V4 Flash Free Max** | `deepseek-v4-flash` | 📋 **Planner** / 🔍 **Researcher** / 👑 **Arbiter** | Основная, быстрая, сбалансированная |
| **North Mini Code Free Med** | ? | 💻 **Coder** | Код, технические задачи |
| **Mimo V2.5 Free Med** | `minimax-m2.5` | ✍️ **Synthesizer** | Креативность, генерация, сборка |
| **Nemotron 3 Ultra Free Max** | `nemotron-3-ultra` | 🔎 **Reviewer** | Глубокий анализ (осторожно: таймауты на длинных промптах) |

## 3 режима работы

### 🤖 Council (параллельный)

```
User → Architect (Big Pickle) → декомпозиция
         ↓
      [Deepseek Researcher] + [North Mini Coder] + [Mimo Writer] — ПАРАЛЛЕЛЬНО
         ↓
      Arbiter (Deepseek) → синтез результатов
         ↓
      Nemotron (Reviewer) → финальное ревью
         ↓
      User ← финальный ответ
```

**Когда:** исследование, сравнение подходов, multi-perspective анализ  
**Скорость:** ~60% времени серийного подхода

### 🔧 Pipeline (последовательный)

```
User → Big Pickle (Architect) → структура
    → Deepseek (Planner) → план
    → North Mini Code (Coder) → реализация
    → Mimo (Synthesizer) → оформление
    → Nemotron (Reviewer) → ревью
    → User
```

**Когда:** code review, перевод, написание документации  
**Скорость:** медленнее, но качество выше

### 🎭 Hybrid (смешанный)

```
User → Big Pickle (Architect) → структура
    → Deepseek (Planner) → детальный план
    → [Coder + Researcher] — ПАРАЛЛЕЛЬНО (research-informed coding)
    → Mimo (Synthesizer) → сборка
    → Nemotron (Reviewer) → финал
```

**Когда:** сложные задачи с research + code

## Процесс

### Шаг 0 — Активация

При получении задачи — **сразу ответить**, не начиная работу:

> 🐝 **Multi-Agent Orchestrator активирован**  
> Задача декомпозируется, собираю команду агентов...

### Шаг 1 — Декомпозиция (Big Pickle Med)

Architect анализирует задачу, определяет:
- Сколько агентов нужно
- Какие роли
- Какой режим (Council / Pipeline / Hybrid)
- Какие модели для каких ролей

### Шаг 2 — Объявление плана

Перед запуском показать таблицу:

```
📋 План работы:
┌──────────────┬────────────────────┬──────────────┐
│ Роль         │ Модель             │ Задача       │
├──────────────┼────────────────────┼──────────────┤
│ 🎯 Architect │ Big Pickle Med     │ ...          │
│ 🔍 Researcher│ Deepseek V4 Flash  │ ...          │
│ 💻 Coder     │ North Mini Code    │ ...          │
│ ✍️ Synthesizer│ Mimo V2.5        │ ...          │
│ 🔎 Reviewer  │ Nemotron 3 Ultra   │ ...          │
└──────────────┴────────────────────┴──────────────┘
Режим: 🤖 Council / 🔧 Pipeline / 🎭 Hybrid
```

### Шаг 3 — Запуск

- **Council:** `delegate_task` с goal для каждого агента, все параллельно
- **Pipeline:** последовательные `delegate_task`, каждый следующий получает контекст предыдущего
- **Hybrid:** первый раунд параллельно, второй — последовательно

### Шаг 4 — Синтез

Arbiter (Deepseek) собирает результаты:
1. Исполнительная сводка (кто что сделал, время)
2. Ключевые выводы (3-5最重要)
3. Детали по темам (сгруппировано по смыслу, не по агентам)
4. Рекомендации

### Шаг 5 — Ревью

Nemotron проверяет финальный ответ на:
- Полноту
- Точность
- Согласованность

## Питфоллы

1. **Nemotron 3 Ultra** может таймаутить на длинных промптах (>200 слов) — заменить на Deepseek V4 Flash
2. **Агенты в одном раунде `delegate_task` не видят друг друга** — зависимые агенты запускать вторым раундом
3. **Всегда сохранять .md файл** перед отправкой пользователю
4. **Объявлять активацию ДО начала работы** — иначе пользователь видит молчание
5. **Не выводить сырые результаты суб-агентов** — всегда синтезировать

## Примеры

### Пример 1: Исследование трёх фреймворков

```
User: "Сравни LangChain, CrewAI и AutoGen"
→ Council mode
→ 3 Researchers (Deepseek V4 Flash) — по одному на фреймворк
→ Synthesizer (Mimo V2.5) — сравнительная таблица
→ Reviewer (Nemotron) — проверка
```

### Пример 2: Code Review + Fix

```
User: "Проверь этот код и исправь проблемы"
→ Pipeline mode
→ Architect (Big Pickle) — анализ структуры
→ Researcher (Deepseek) — поиск best practices
→ Coder (North Mini Code) — исправление
→ Reviewer (Nemotron) — финальное ревью
```
