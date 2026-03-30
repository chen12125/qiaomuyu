#!/bin/bash
# 停止 GitHub 提交验证监控器

WORKSPACE="/home/chenzhao/.openclaw/workspace/wooden-fish-app"
PID_FILE="$WORKSPACE/verify/.monitor.pid"

if [ -f "$PID_FILE" ]; then
    pid=$(cat "$PID_FILE")
    if kill -0 "$pid" 2>/dev/null; then
        kill "$pid"
        echo "Stopping monitor (PID: $pid)..."
        rm -f "$PID_FILE"
        echo "✅ Monitor stopped"
    else
        echo "Stale PID file, cleaning up..."
        rm -f "$PID_FILE"
    fi
else
    echo "Monitor not running"
fi