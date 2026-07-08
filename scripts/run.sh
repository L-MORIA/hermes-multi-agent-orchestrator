#!/usr/bin/env bash
# ============================================================
# Hermes Multi-Agent Orchestrator — запуск разных моделей
# через OpenCode CLI с --model флагом
# РЕАЛЬНЫЙ ПАРАЛЛЕЛЬНЫЙ ЗАПУСК
# ============================================================
set -euo pipefail

CACHE_DIR="/c/Users/moria/AppData/Local/hermes/cache/orchestrator"
mkdir -p "$CACHE_DIR"

# === Модели OpenCode Zen — имена из пикера → model ID ===
declare -A MODELS
MODELS["Big Pickle Med"]="opencode/big-pickle"
MODELS["Deepseek V4 Flash"]="opencode/deepseek-v4-flash-free"
MODELS["Mimo V2.5"]="opencode/mimo-v2.5-free"
MODELS["Nemotron 3 Ultra"]="opencode/nemotron-3-ultra-free"
MODELS["North Mini Code"]="opencode/north-mini-code-free"

# === Council mode ===
# Запускает N агентов ПАРАЛЛЕЛЬНО с разными моделями
run_council() {
    local agents=("$@")  # формат: "Модель:Задача"
    local pids=()
    local names=()
    local results=()

    echo "🐝 Council: ${#agents[@]} агентов, разные модели (ПАРАЛЛЕЛЬНО)"
    echo ""

    for agent in "${agents[@]}"; do
        local model="${agent%%:*}"
        local goal="${agent#*:}"
        local model_id="${MODELS[$model]:-$model}"
        local slug="${model// /_}"
        local out="$CACHE_DIR/council_${slug}_$$.md"
        
        echo "  ▶️  [$model] ${goal:0:60}..."
        
        # Каждый агент в своём фоновом процессе
        (
            opencode run "$goal" --model "$model_id" > "$out" 2>&1
        ) &
        
        pids+=($!)
        names+=("$model")
        results+=("$out")
    done

    echo ""
    echo "⏳ Жду ${#pids[@]} агентов..."
    
    local i=0
    for pid in "${pids[@]}"; do
        if wait "$pid" 2>/dev/null; then
            status="✅"
        else
            status="⚠️"
        fi
        echo "  $status [${names[$i]}] завершил"
        ((i++))
    done

    echo ""
    echo "=== РЕЗУЛЬТАТЫ ==="
    echo ""
    local ri=0
    for res in "${results[@]}"; do
        if [ -f "$res" ] && [ -s "$res" ]; then
            echo "────────────────────────────────────────"
            echo "  ${names[$ri]}:"
            echo "────────────────────────────────────────"
            cat "$res"
            echo ""
        fi
        ((ri++))
    done

    echo "================================================"
    echo "📁 Результаты сохранены в: $CACHE_DIR"
    echo "  ${results[*]}"
}

# === Pipeline mode ===
run_pipeline() {
    local context="$1"
    shift
    local stages=("$@")  # формат: "Модель:Задача"
    local prev=""

    echo "🔧 Pipeline: ${#stages[@]} этапов"
    echo ""

    for stage in "${stages[@]}"; do
        local model="${stage%%:*}"
        local goal="${stage#*:}"
        local model_id="${MODELS[$model]:-$model}"
        local slug="${model// /_}"
        local out="$CACHE_DIR/pipeline_${slug}_$$.md"
        
        echo "  ➡️  [$model] ${goal:0:60}..."
        
        if [ -n "$context" ]; then
            opencode run "Контекст: $context. Задача: $goal" --model "$model_id" > "$out" 2>&1
        else
            opencode run "$goal" --model "$model_id" > "$out" 2>&1
        fi
        
        context=$(cat "$out" 2>/dev/null || echo "error")
        echo "  ✅ [$model] готов"
        echo ""
    done

    echo "=== ФИНАЛЬНЫЙ РЕЗУЛЬТАТ ==="
    cat "$CACHE_DIR/pipeline_${stages[-1]%%:*}_$$.md" 2>/dev/null || echo "(empty)"
}

# === Help ===
usage() {
    echo "Hermes Multi-Agent Orchestrator"
    echo ""
    echo "Council (параллельно):"
    echo '  ./run.sh council "Модель:Задача" "Модель:Задача" ...'
    echo ""
    echo "Pipeline (последовательно):"
    echo '  ./run.sh pipeline "контекст" "Модель:Задача" "Модель:Задача" ...'
    echo ""
    echo "Пример Council:"
    echo '  ./run.sh council \'
    echo '    "Big Pickle Med:Спроектируй архитектуру" \'
    echo '    "Deepseek V4 Flash:Исследуй LangChain" \'
    echo '    "Mimo V2.5:Исследуй CrewAI"'
    echo ""
    echo "Пример Pipeline:"
    echo '  ./run.sh pipeline "напиши парсер csv" \'
    echo '    "Big Pickle Med:спроектируй" \'
    echo '    "North Mini Code:напиши код" \'
    echo '    "Nemotron 3 Ultra:проверь"'
    echo ""
    echo "Модели: ${!MODELS[*]}"
}

case "${1:-}" in
    council) shift; run_council "$@" ;;
    pipeline) shift; run_pipeline "$@" ;;
    *) usage ;;
esac
