#!/bin/bash

# IFS編集
OLDIFS=$IFS
IFS=,

# リストファイル定義
textlist=$(cat <<EOS
1-1,test1,cmd,echo a
1-2,test2,cmd,echo b
EOS
)


# 行ループ
while read -a arr; do

echo "-------- Loop -------"
echo "arr[*]: ${arr[*]}"
echo "arr[0]: ${arr[0]}"
echo "arr[1]: ${arr[1]}"
echo "arr[2]: ${arr[2]}"
echo "arr[3]: ${arr[3]}"
echo "arr[d]: $(eval ${arr[3]})"

done < <(echo "$textlist")

# IFS戻し
IFS=$OLDIFS
