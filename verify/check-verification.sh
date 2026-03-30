#!/bin/bash
# 检查并返回验证结果

WORKSPACE="/home/chenzhao/.openclaw/workspace/wooden-fish-app"
RESULT_FILE="$WORKSPACE/verify/verification-results.md"

if [ -f "$RESULT_FILE" ]; then
    # 检查是否有新的验证结果
    if grep -q "✅ GitHub 提交验证通过" "$RESULT_FILE"; then
        echo "VERIFICATION_PASSED"
        echo ""
        cat "$RESULT_FILE"
    elif grep -q "❌ GitHub 提交验证失败" "$RESULT_FILE"; then
        echo "VERIFICATION_FAILED"
        echo ""
        cat "$RESULT_FILE"
    else
        echo "VERIFICATION_PENDING"
        echo ""
        cat "$RESULT_FILE"
    fi
else
    echo "VERIFICATION_NOT_READY"
    echo "Verification results file not found"
fi