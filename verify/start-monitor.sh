#!/bin/bash
# 启动 GitHub 提交验证监控器

WORKSPACE="/home/chenzhao/.openclaw/workspace/wooden-fish-app"
MONITOR_SCRIPT="$WORKSPACE/verify/monitor.sh"
LOG_FILE="$WORKSPACE/verify/monitor.log"
PID_FILE="$WORKSPACE/verify/.monitor.pid"
RESULT_FILE="$WORKSPACE/verify/verification-results.md"

# 检查是否已在运行
if [ -f "$PID_FILE" ]; then
    pid=$(cat "$PID_FILE")
    if kill -0 "$pid" 2>/dev/null; then
        echo "Monitor already running (PID: $pid)"
        exit 0
    else
        echo "Stale PID file, cleaning up..."
        rm -f "$PID_FILE"
    fi
fi

# 初始化结果文件
cat > "$RESULT_FILE" << 'EOF'
# GitHub 提交验证报告

**项目**: 敲木鱼安卓应用 (wooden-fish-app)  
**仓库**: git@github.com:chen12125/qiaomuyu.git  

## 📊 验证状态

🟡 **验证监控器已启动**  

监控器正在检查本地和远程仓库的同步状态...

---

_此验证报告由外部验证系统自动生成_  
_最后更新: INITIALIZED
EOF

# 启动监控器（后台）
echo "Starting GitHub verification monitor..."
chmod +x "$MONITOR_SCRIPT"
nohup bash "$MONITOR_SCRIPT" >> "$LOG_FILE" 2>&1 &
pid=$!
echo $pid > "$PID_FILE"

echo "✅ GitHub verification monitor started (PID: $pid)"
echo "📄 Log file: $LOG_FILE"
echo "📄 Results file: $RESULT_FILE"
echo ""
echo "To stop: ./verify/stop-monitor.sh"
echo "To check status: ./verify/status.sh"
echo "To check results: cat ./verify/verification-results.md"