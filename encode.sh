#!/bin/bash

# 字符串
read -e -p  $'\e[1;32mCode:\n\e[0m' string
save=""
# 转换为ASCII数字编码
for ((i=0; i<${#string}; i++)); do
    ascii=$(printf "%d" "'${string:$i:1}")
    save=$save\\${ascii}
    
    echo ${ascii}
done
echo -e "Code:\n${save}"
read -e -p $'是否保存？\n请输入:Y/n\n你输入的是' choice
case $choice in
    Y)
    echo "loadstring('${save}')()">神秘斜杠加密.txt
    echo "保存成功"
    ;;
    n)
    echo "执行No"
    ;;
    *)
    echo "无效"
    ;;
    esac