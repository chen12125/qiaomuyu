#!/bin/bash
# 检查 GitHub 提交验证监控器状态

WORKSPACE="/home/chenzhao/.openclaw/workspace/wooden-fish-app"
PID_FILE="$WORKSPACE/verify/.monitor.pid"
LOG_FILE="$WORKSPACE/verify/monitor.log"
RESULT_FILE="$WORKSPACE/verify/verification-results.md"

echo "=== GitHub Verification Monitor Status ==="
echo ""

# 检查监控器是否运行
if [ -f "$PID_FILE" ]; then
    pid=$(cat "$PID_FILE")
    if kill -0 "$pid" 2>/dev/null; then
        echo "🟢 Status: Running (PID: $pid)"
    else
        echo "🔴 Status: Not running (stale PID)"
    fi
else
    echo "🔴 Status: Not running"
fi

echo ""
echo "📄 Log file: $LOG_FILE"
if [ -f "$LOG_FILE" ]; then
    echo "   Size: $(wc -c < "$LOG_FILE") bytes"
    echo "   Last 5 lines:"
    tail -5 "$LOG_FILE" | sed 's/^/   /'
else
    echo "   File not found"
fi

echo ""
echo "📄 Results file: $RESULT_FILE"
if [ -f "$RESULT_FILE" ]; then
    echo "   Size: $(wc -c < "$RESULT_FILE") bytes"
    echo "   Last updated: $(stat -c %y "$RESULT_FILE" 2>/dev/null || echo "unknown")"
else
    echo "   File not found"
fi

echo ""
echo "📊 Git Status:"
cd "$WORKSPACE" && git status --porcelain