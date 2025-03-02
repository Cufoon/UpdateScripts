#!/bin/bash

# 获取当前脚本所在目录（兼容符号链接）
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

# 切换到脚本所在目录
cd "$SCRIPT_DIR" || exit 1

# 获取当前脚本名称（排除自身执行）
current_script=$(basename "$0")

for script in *.sh; do
    if [ "$script" != "$current_script" ]; then
        if [ -x "$script" ] && [ -f "$script" ]; then
            echo "正在执行脚本: $script"
            ./"$script"
        else
            echo "警告: $script 不可执行或非普通文件，已跳过"
        fi
    fi
done

echo "所有脚本执行完成"
