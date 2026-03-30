#!/bin/bash
# GitHub 提交验证监控器
# 专门用于验证敲木鱼项目的远程推送

WORKSPACE="/home/chenzhao/.openclaw/workspace/wooden-fish-app"
LOG_FILE="$WORKSPACE/verify/monitor.log"
RESULT_FILE="$WORKSPACE/verify/verification-results.md"
STATE_FILE="$WORKSPACE/verify/.state.json"

# 创建初始状态文件
if [ ! -f "$STATE_FILE" ]; then
    cat > "$STATE_FILE" << 'EOF'
{
    "last_commit": "",
    "last_remote_commit": "",
    "last_check": "",
    "pending_changes": false
}
EOF
fi

monitor_changes() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [MONITOR] === Monitor Started ===" | tee -a "$LOG_FILE"
    
    while true; do
        # 检查本地是否有新提交
        local_commit=$(cd "$WORKSPACE" && git log --oneline -1 --format="%H" 2>/dev/null || echo "")
        
        # 检查远程仓库
        remote_commit=""
        if git ls-remote origin HEAD >/dev/null 2>&1; then
            remote_commit=$(git ls-remote origin HEAD | cut -f1)
        fi
        
        # 比较本地和远程提交
        if [ "$local_commit" != "" ] && [ "$remote_commit" != "" ]; then
            if [ "$local_commit" = "$remote_commit" ]; then
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] [VERIFY] ✅ GitHub 提交验证通过" | tee -a "$LOG_FILE"
                
                # 更新验证结果
                cat > "$RESULT_FILE" << EOF
# GitHub 提交验证报告

**项目**: 敲木鱼安卓应用 (wooden-fish-app)  
**仓库**: git@github.com:chen12125/qiaomuyu.git  
**验证时间**: $(date '+%Y-%m-%d %H:%M:%S')  

## 📊 验证结果

✅ **GitHub 提交验证通过**  

**本地提交**: ${local_commit:0:8}  
**远程提交**: ${remote_commit:0:8}  

验证通过，代码已成功同步到 GitHub 远程仓库。

## 📋 项目状态

- **仓库地址**: git@github.com:chen12125/qiaomuyu.git
- **最新提交**: ${local_commit:0:8}
- **同步状态**: ✅ 已同步
- **验证时间**: $(date '+%Y-%m-%d %H:%M:%S')

---

_此验证报告由外部验证系统自动生成_  
_最后更新: $(date '+%Y-%m-%d %H:%M:%S')_
EOF
            else
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] [VERIFY] ❌ GitHub 提交验证失败" | tee -a "$LOG_FILE"
                
                cat > "$RESULT_FILE" << EOF
# GitHub 提交验证报告

**项目**: 敲木鱼安卓应用 (wooden-fish-app)  
**仓库**: git@github.com:chen12125/qiaomuyu.git  
**验证时间**: $(date '+%Y-%m-%d %H:%M:%S')  

## 📊 验证结果

❌ **GitHub 提交验证失败**  

**本地提交**: ${local_commit:0:8}  
**远程提交**: ${remote_commit:0:8}  

⚠️ **警告**: 本地提交与远程仓库不同步！

请执行以下命令同步代码：
\`\`\`bash
git push origin master
\`\`\`

## 📋 项目状态

- **仓库地址**: git@github.com:chen12125/qiaomuyu.git
- **本地提交**: ${local_commit:0:8}
- **远程提交**: ${remote_commit:0:8}
- **同步状态**: ❌ 未同步
- **验证时间**: $(date '+%Y-%m-%d %H:%M:%S')

---

_此验证报告由外部验证系统自动生成_  
_最后更新: $(date '+%Y-%m-%d %H:%M:%S')_
EOF
            fi
        else
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [VERIFY] ⚠️ 无法获取提交信息" | tee -a "$LOG_FILE"
        fi
        
        sleep 30  # 每30秒检查一次
    done
}

# 执行监控
monitor_changes