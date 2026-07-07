#!/usr/bin/env bash
# ============================================================
# Hermes Multi-Agent Orchestrator — запуск разных моделей
# через OpenCode CLI с --model флагом
#
# Usage:
#   ./run_council.sh "Сравни фреймворки" --models
#   ./run_pipeline.sh "Напиши парсер" --output report.md
# ============================================================
set -euo pipefail

MODELS_DIR="/c/Users/moria/AppData/Local/hermes/cache/orchestrator"
mkdir -p "$MODELS_DIR"

# === Модели OpenCode Zen — имена из пикера ===
declare -A MODELS
# Имя в пикере → model ID (opencode CLI)
MODELS["Big Pickle Med"]="opencode/big-pickle"
MODELS["Deepseek V4 Flash"]="opencode/deepseek-v4-flash-free"
MODELS["Mimo V2.5"]="opencode/mimo-v2.5-free"
MODELS["Nemotron 3 Ultra"]="opencode/nemotron-3-ultra-free"
MODELS["North Mini Code"]="opencode/north-mini-code-free"

# === Council mode ===
# Запускает N агентов параллельно с разными моделями
run_council() {
    local task="$1"
    shift
    local agents=("$@")  # список "модель:задача"
    
    local pids=()
    local results=()
    local i=0
    
    echo "🐝 Council mode: ${#agents[@]} агентов, разные модели"
    echo ""
    
    for agent in "${agents[@]}"; do
        local model="${agent%%:*}"
        local goal="${agent#*:}"
        local model_id="${MODELS[$model]:-$model}"
        local outfile="$MODELS_DIR/result_${i}_${model}.md"
        
        echo "  🔍 Агент $i: $model ($model_id)"
        echo "     Задача: ${goal:0:60}..."
        echo "     → $outfile"
        
        # Запуск в фоне с конкретной моделью
        opencode --provider opencode-zen \
                 --model "$model_id" \
                 --prompt "Выполни задачу: $goal. 
                          Язык: русский. 
                          Выведи ТОЛЬКО результат, без пояснений." \
                 --output "$outfile" &
        
        pids+=($!)
        results+=("$outfile")
        ((i++))
    done
    
    # Ждём все параллельные задачи
    echo ""
    echo "⏳ Жду ${#pids[@]} агентов..."
    for pid in "${pids[@]}"; do
        wait "$pid" 2>/dev/null || true
    done
    echo "✅ Все агенты завершили"
    echo ""
    
    # Выводим результаты
    for res in "${results[@]}"; do
        if [ -f "$res" ]; then
            echo "=== $(basename $res) ==="
            cat "$res"
            echo ""
        fi
    done
}

# === Pipeline mode ===
# Запускает агентов последовательно, каждый получает контекст
run_pipeline() {
    local task="$1"
    shift
    local stages=("$@")  # список "модель:задача"
    
    local context="$task"
    local prev=""
    
    echo "🔧 Pipeline mode: ${#stages[@]} этапов"
    echo ""
    
    for stage in "${stages[@]}"; do
        local model="${stage%%:*}"
        local goal="${stage#*:}"
        local model_id="${MODELS[$model]:-$model}"
        local outfile="$MODELS_DIR/pipeline_${model}.md"
        
        echo "  ➡️  $model ($model_id): ${goal:0:60}..."
        
        opencode --provider opencode-zen \
                 --model "$model_id" \
                 --prompt "Контекст задачи: $context
                          
                          Твоя задача: $goal
                          
                          Язык: русский.
                          Выведи ТОЛЬКО результат." \
                 --output "$outfile"
        
        if [ -f "$outfile" ]; then
            context=$(cat "$outfile")
            prev="$outfile"
        fi
        echo "  ✅ $model готов"
        echo ""
    done
    
    echo "✅ Pipeline завершён"
    echo ""
    echo "=== Финальный результат ==="
    [ -n "$prev" ] && cat "$prev"
}

# === Help ===
usage() {
    echo "Usage:"
    echo "  ./run_council.sh \"задача\" model1:goal1 model2:goal2 ..."
    echo "  ./run_pipeline.sh \"задача\" model1:goal1 model2:goal2 ..."
    echo ""
    echo "Пример Council:"
    echo "  ./run_council.sh \"Сравни фреймворки\" \\"
    echo "    deepseek:\"Исследуй LangChain\" \\"
    echo "    mimo:\"Исследуй CrewAI\" \\"
    echo "    north-mini:\"Исследуй AutoGen\""
    echo ""
    echo "Пример Pipeline:"
    echo "  ./run_pipeline.sh \"Напиши парсер CSV\" \\"
    echo "    deepseek:\"Спроектируй архитектуру\" \\"
    echo "    north-mini:\"Напиши код\" \\"
    echo "    nemotron:\"Проверь код на ошибки\""
}

case "${1:-}" in
    council|--council)
        shift
        run_council "$@"
        ;;
    pipeline|--pipeline)
        shift
        run_pipeline "$@"
        ;;
    *)
        usage
        ;;
esac
