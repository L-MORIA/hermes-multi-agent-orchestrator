# Smoke Test Results — 2026-07-08

## Council Mode: Сравнение AI-фреймворков (LangChain vs CrewAI)

### Выполнение

| # | Роль | Модель | Model ID | Размер | Строк | Статус |
|---|------|--------|----------|--------|-------|--------|
| 1 | 🎯 **Architect** | **Big Pickle Med** | `opencode/big-pickle` | 5426B | 78 | ✅ |
| 2 | 🔍 **Researcher A** | **Deepseek V4 Flash** | `opencode/deepseek-v4-flash-free` | 3334B | 12 | ✅ |
| 3 | 🔍 **Researcher B** | **Mimo V2.5** | `opencode/mimo-v2.5-free` | 3819B | 14 | ✅ |
| 4 | 👑 **Arbiter** | **Nemotron 3 Ultra** | `opencode/nemotron-3-ultra-free` | — | — | ✅ |

### Pipeline Mode: CSV Parser

| # | Шаг | Модель | Результат | Статус |
|---|-----|--------|-----------|--------|
| 1 | 🎯 **Architect** | Big Pickle Med | Архитектура: csv_parser/ с parser.py, cli.py, config.py | ✅ |
| 2 | 💻 **Coder** | North Mini Code | Сгенерировал 3 файла, 3 итерации правок, создал на диске | ✅ |

### Качество арбитра: Mimo vs Nemotron

| Критерий | Mimo V2.5 | 👑 Nemotron 3 Ultra |
|----------|-----------|-------------------|
| Оси сравнения | 7 (общие) | 7 (глубокие) |
| Различия | 5 (поверхностные) | 5 (конкретные: парадигма, multi-agent, память, observability, экосистема) |
| Вердикт | 4 сценария | **7 сценариев** |
| Глубина | Средняя | **Высокая** |

**Вывод:** Nemotron 3 Ultra — лучший арбитр. Глубокий анализ, без таймаутов.

### Полные ответы агентов

```
/c/Users/moria/AppData/Local/hermes/cache/orchestrator/
├── council_Big_Pickle_Med_642.md     — 5426B, 78 строк
├── council_Deepseek_V4_Flash_642.md  — 3334B, 12 строк
├── council_Mimo_V2.5_642.md          — 3819B, 14 строк
```

### Сводка по всем 5 моделям

| Модель | Model ID | Роль | Статус |
|--------|----------|------|--------|
| 🎯 Big Pickle Med | `opencode/big-pickle` | Architect | ✅ Архитектура, декомпозиция |
| 📋 Deepseek V4 Flash | `opencode/deepseek-v4-flash-free` | Planner / Researcher | ✅ Факты, логика, глубина |
| ✍️ Mimo V2.5 | `opencode/mimo-v2.5-free` | Synthesizer | ✅ Креативная сборка |
| 👑 Nemotron 3 Ultra | `opencode/nemotron-3-ultra-free` | Arbiter / Reviewer | ✅ Глубокий синтез |
| 💻 North Mini Code | `opencode/north-mini-code-free` | Coder | ✅ Пишет и создаёт файлы |

### Команды для воспроизведения

```bash
# Council (3 исследователя + арбитр)
bash scripts/run.sh council \
  "Big Pickle Med:задача" \
  "Deepseek V4 Flash:задача" \
  "Mimo V2.5:задача"

# Арбитр вручную
opencode run "контекст" --model "opencode/nemotron-3-ultra-free"

# Pipeline
bash scripts/run.sh pipeline "контекст" \
  "Big Pickle Med:спроектируй" \
  "North Mini Code:напиши код"
```
