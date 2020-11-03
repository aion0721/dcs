#!/bin/bash

# IFS編集
OLDIFS=$IFS
IFS=,

# 一時ディレクトリ生成
sourcePath=`mktemp -d`
# ファイル名定義
fileName=$(date "+%Y%m%d_%H%M%S")_dcs

# リストファイル定義
textlist=$(cat <<EOS
1-1,test1,cmd,echo a
1-2,test2,cmd,echo b
1-3,ifconfig,cmd,ifconfig
2-1,secure,path,/var/log/messages
2-2,syslog,path,/var/log/syslog
2-3,ruby-helper,path,/root/spec/spec_helper.rb
EOS
)

echo $textlist > $sourcePath/textlist.txt

# 行ループ
while read -a arr; do

# 変数定義
snum=${arr[0]}
stitle=${arr[1]}
category=${arr[2]}
args=${arr[3]}

echo "-------- Loop -------"
echo "arr[*]: ${arr[*]}"
echo "arr[0]: ${arr[0]}"
echo "arr[1]: ${arr[1]}"
echo "arr[2]: ${arr[2]}"
echo "arr[3]: ${arr[3]}"
echo "arr[d]: $(eval ${arr[3]})"

# 処理判断
# cmdの場合コマンド処理
if [ ${category} = "cmd" ]; then
	res=$(eval ${args})
	echo $res > ${sourcePath}/${snum}_${stitle}.txt

# pathの場合ファイルコピー
elif [ ${category} = "path" ]; then
	mkdir $sourcePath/${snum}_${stitle}
	cp -p ${args} $sourcePath/${snum}_${stitle}/
fi

done < <(echo "$textlist")

# IFS戻し
IFS=$OLDIFS

# 一時ファイル処理
tar czvf /tmp/${fileName}.tar.gz ${sourcePath}

# 削除 
rm -Rf ${sourcePath}
