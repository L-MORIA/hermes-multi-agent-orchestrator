# Hermes Multi-Agent Orchestrator

**Мульти-агентная оркестрация для Hermes Agent на бесплатных моделях OpenCode Zen.**

Замени одного агента — командой агентов. Преврати последовательность — в параллель.
3 режима, 5 ролей, 5 разных моделей. Все модели проверены смок-тестом.

## Модели (OpenCode Zen — Бесплатные)

| Роль | Модель | Model ID | Сильные стороны |
|------|--------|----------|----------------|
| 🎯 **Архитектор** | Big Pickle Med | `opencode/big-pickle` | Архитектура, креатив, мета-планирование |
| 📋 **Планировщик / 🔍 Исследователь** | Deepseek V4 Flash | `opencode/deepseek-v4-flash-free` | Скорость, факты, логика |
| ✍️ **Синтезатор** | Mimo V2.5 | `opencode/mimo-v2.5-free` | Креатив, генерация, описание |
| 👑 **Арбитр / 🔎 Ревьюер** | **Nemotron 3 Ultra** | `opencode/nemotron-3-ultra-free` | **Глубокий анализ, синтез** |
| 💻 **Кодер** | North Mini Code | `opencode/north-mini-code-free` | Код, файлы |

> ⚠️ **Nemotron 3 Ultra — арбитр.** Именно он делает финальный синтез. Не Mimo, не Deepseek.

## Режимы

| Режим | Паттерн | Когда использовать |
|-------|---------|-------------------|
| 🤖 **Council** | Параллельно → Арбитр синтезирует | Исследование, сравнение |
| 🔧 **Pipeline** | A → B → C → Арбитр | Code review, документы |
| 🎭 **Hybrid** | Сначала параллель, потом последовательно | Сложные задачи |

## Быстрый старт

### Council: параллельное исследование

```bash
opencode run "Исследуй LangChain" --model "opencode/deepseek-v4-flash-free" &
opencode run "Исследуй CrewAI" --model "opencode/mimo-v2.5-free" &
opencode run "Архитектура сравнения" --model "opencode/big-pickle" &
wait

opencode run "Синтез: $(cat results)" --model "opencode/nemotron-3-ultra-free"
```

### Pipeline: код

```bash
bash scripts/run.sh pipeline "напиши парсер" \
  "Big Pickle Med:спроектируй" \
  "North Mini Code:напиши код"
```

## Результаты тестов

Все 5 моделей протестированы. Полные результаты в [TEST_RESULTS.md](TEST_RESULTS.md).

| Модель | Роль | Статус |
|--------|------|--------|
| Big Pickle Med | 🎯 Architect | ✅ Архитектура, 10 осей |
| Deepseek V4 Flash | 🔍 Researcher | ✅ Глубокие факты |
| Mimo V2.5 | ✍️ Synthesizer | ✅ Креативная сборка |
| Nemotron 3 Ultra | 👑 Arbiter | ✅ **Лучший синтез** |
| North Mini Code | 💻 Coder | ✅ Реальный код |

## Установка

```bash
git clone https://github.com/L-MORIA/hermes-multi-agent-orchestrator.git
cp -r hermes-multi-agent-orchestrator ~/.hermes/skills/
/reload-skills
```

## Питфоллы

- **Nemotron 3 Ultra** может таймаутить на >5000 токенов — разбивать
- **Параллельные агенты изолированы** — зависимые задачи вторым раундом
- **Объявлять активацию ДО работы**
- **Не выводить сырые результаты** — всегда через арбитра
- **`2>&1` вместо `2>/dev/null`** — stderr содержит важную информацию
