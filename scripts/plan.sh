#!/usr/bin/env bash
# Шаблон объявления плана перед multi-agent запуском
# Скопировать и вставить в чат перед вызовом delegate_task
set -euo pipefail

MODE="${1:-council}"  # council | pipeline | hybrid
TASK="$2"

echo "🐝 **Multi-Agent Orchestrator активирован**"
echo ""
echo "📋 Задача: $TASK"
echo "Режим: $(case $MODE in
  council) echo "🤖 Council (параллельный)" ;;
  pipeline) echo "🔧 Pipeline (последовательный)" ;;
  hybrid) echo "🎭 Hybrid (смешанный)" ;;
esac)"
echo ""
echo "┌──────────────┬────────────────────┬─────────────────────────────┐"
echo "│ Роль         │ Модель             │ Задача                      │"
echo "├──────────────┼────────────────────┼─────────────────────────────┤"

case $MODE in
  council)
    echo "│ 🔍 Researcher 1│ Deepseek V4 Flash  │ Аспект A                    │"
    echo "│ 🔍 Researcher 2│ Deepseek V4 Flash  │ Аспект B                    │"
    echo "│ 💻 Coder      │ North Mini Code    │ Реализация                  │"
    echo "│ 🎯 Architect  │ Big Pickle Med     │ Структура решения           │"
    echo "├──────────────┼────────────────────┼─────────────────────────────┤"
    echo "│ ✍️ Synthesizer│ Mimo V2.5          │ Сборка результатов          │"
    echo "│ 🔎 Reviewer  │ Nemotron 3 Ultra   │ Финальная проверка          │"
    ;;
  pipeline)
    echo "│ 🎯 Step 1     │ Big Pickle Med     │ Архитектура                 │"
    echo "│ 📋 Step 2     │ Deepseek V4 Flash  │ План                        │"
    echo "│ 💻 Step 3     │ North Mini Code    │ Реализация                  │"
    echo "│ ✍️ Step 4     │ Mimo V2.5          │ Оформление                  │"
    echo "│ 🔎 Step 5     │ Nemotron 3 Ultra   │ Ревью                       │"
    ;;
  hybrid)
    echo "│ 🎯 Architect  │ Big Pickle Med     │ Декомпозиция                │"
    echo "│ 📋 Planner    │ Deepseek V4 Flash  │ План                        │"
    echo "├──────────────┼────────────────────┼─────────────────────────────┤"
    echo "│ 🔍 Researcher │ Deepseek V4 Flash  │ Исследование                │"
    echo "│ 💻 Coder      │ North Mini Code    │ Реализация                  │"
    echo "├──────────────┼────────────────────┼─────────────────────────────┤"
    echo "│ ✍️ Synthesizer│ Mimo V2.5          │ Сборка                      │"
    echo "│ 🔎 Reviewer  │ Nemotron 3 Ultra   │ Проверка                    │"
    ;;
esac

echo "└──────────────┴────────────────────┴─────────────────────────────┘"
echo ""
echo "⏳ Запускаю агентов..."
