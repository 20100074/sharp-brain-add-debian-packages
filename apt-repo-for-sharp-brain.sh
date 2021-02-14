#!/usr/bin/env bash

# written by 20100074 in 2021-01-11 01:20 JST.
# Changelog:
# version 1.0: initial version (2021-01-11)

# make sure `sed` is GNU sed.
# In Linux, `awk` and `sed` are both GNU version.

BRAIN_CPUARCH="armel"

SCRIPT_VERSION="1.0"
SCRIPT_DATE="2021-01-11"

DEFAULT_TEXT_COLOR='\033[0m'
RED_TEXT_COLOR='\033[0;31m'
GREEN_TEXT_COLOR='\033[0;32m'

ROWS=$(stty size | gawk '{print $2}')
COLS=$(stty size | gawk '{print $1}')

# Banner
for i in $(seq 1 $ROWS); do printf "-"; done; printf "\n";

echo "SHARP Brain Debian APT Source Manager (version: $SCRIPT_VERSION, date: $SCRIPT_DATE)"
echo "This script was written by Koshikawa Kenichi."

for i in $(seq 1 $ROWS); do printf "-"; done; printf "\n";

# ask for sudo permission
echo -e "\n作業を自動化するため，sudoパスワードを事前に伺います。"

sudo -v

if [ $? = 0 ]; then
	echo ""
	echo -e "${GREEN_TEXT_COLOR}認証に成功しました。処理を続行します。${DEFAULT_TEXT_COLOR}"
else
	echo ""
	echo -e "${RED_TEXT_COLOR}認証に失敗しました。処理を中断します。${DEFAULT_TEXT_COLOR}"
	exit
fi

if [ $(uname) != "Linux" ] || [ $(which apt) = "" ] || [ $(which apt-get) = "" ]; then
	echo ""
	echo -e "\e[4m\e[1m${RED_TEXT_COLOR}お使いのOSがLinuxでないか，aptコマンドが見つかりません。${DEFAULT_TEXT_COLOR}\e[0m\e[0m"
	echo -e "${RED_TEXT_COLOR}安全のため，処理を中断します。${DEFAULT_TEXT_COLOR} \n"
	echo "システム情報: $(uname -a)"
	echo "PATH: $(echo $PATH)"
	exit
fi

# whoami | tee -a whoami.txt

# add repo(s) to sources.list
if [ $(uname) = "Linux" ]; then
	echo "APTのソースリストにリポジトリを追加しています..."
	sudo apt-get install debian-keyring debian-archive-keyring -y

	if [ $BRAIN_CPUARCH = "armel" ]; then
		echo -e '\n\n' | sudo tee -a /etc/apt/sources.list
		echo '#following repositories are for SHARP Brain.' | sudo tee -a /etc/apt/sources.list
		echo 'deb [arch=armel] https://ftp.jaist.ac.jp/pub/Linux/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list				# HTTPS
		echo 'deb-src [arch=armel] https://ftp.jaist.ac.jp/pub/Linux/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list		# HTTPS
		echo '#deb [arch=armel] http://ftp.jaist.ac.jp/pub/Linux/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo '#deb-src [arch=armel] http://ftp.jaist.ac.jp/pub/Linux/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo '#deb [arch=armel] http://ftp.jp.debian.org/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list			# フォールバックとして追加。
		echo '#deb-src [arch=armel] http://ftp.jp.debian.org/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list	# フォールバックとして追加。
		#
		echo 'deb [arch=armel] https://ftp.jaist.ac.jp/pub/Linux/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list				# HTTPS
		echo 'deb-src [arch=armel] https://ftp.jaist.ac.jp/pub/Linux/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list		# HTTPS
		echo '#deb [arch=armel] http://ftp.jaist.ac.jp/pub/Linux/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo '#deb-src [arch=armel] http://ftp.jaist.ac.jp/pub/Linux/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo '#deb [arch=armel] http://ftp.jp.debian.org/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list			# フォールバックとして追加。
		echo '#deb-src [arch=armel] http://ftp.jp.debian.org/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list	# フォールバックとして追加。
		#
		echo 'deb http://security.debian.org/debian-security buster/updates main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo 'deb-src http://security.debian.org/debian-security buster/updates main contrib non-free' | sudo tee -a /etc/apt/sources.list
	elif [ $BRAIN_CPUARCH = "armhf" ]; then
		echo -e '\n\n' | sudo tee -a /etc/apt/sources.list
		echo '#following repositories are for SHARP Brain.' | sudo tee -a /etc/apt/sources.list
		echo 'deb [arch=armhf] https://ftp.jaist.ac.jp/pub/Linux/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list				# HTTPS
		echo 'deb-src [arch=armhf] https://ftp.jaist.ac.jp/pub/Linux/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list		# HTTPS
		echo '#deb [arch=armhf] http://ftp.jaist.ac.jp/pub/Linux/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo '#deb-src [arch=armhf] http://ftp.jaist.ac.jp/pub/Linux/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo '#deb [arch=armhf] http://ftp.jp.debian.org/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list			# フォールバックとして追加。
		echo '#deb-src [arch=armhf] http://ftp.jp.debian.org/debian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list	# フォールバックとして追加。
		#
		echo 'deb [arch=armhf] https://ftp.jaist.ac.jp/pub/Linux/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list				# HTTPS
		echo 'deb-src [arch=armhf] https://ftp.jaist.ac.jp/pub/Linux/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list		# HTTPS
		echo '#deb [arch=armhf] http://ftp.jaist.ac.jp/pub/Linux/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo '#deb-src [arch=armhf] http://ftp.jaist.ac.jp/pub/Linux/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo '#deb [arch=armhf] http://ftp.jp.debian.org/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list			# フォールバックとして追加。
		echo '#deb-src [arch=armhf] http://ftp.jp.debian.org/debian buster-updates main contrib non-free' | sudo tee -a /etc/apt/sources.list	# フォールバックとして追加。
		#
		echo 'deb http://security.debian.org/debian-security buster/updates main contrib non-free' | sudo tee -a /etc/apt/sources.list
		echo 'deb-src http://security.debian.org/debian-security buster/updates main contrib non-free' | sudo tee -a /etc/apt/sources.list
	fi
fi

# add arch
if [ $(uname) = "Linux" ]; then
	echo "dpkgにアーキテクチャ設定を追加しています..."
	if [ $BRAIN_CPUARCH = "armel" ]; then
		sudo dpkg --add-architecture armel
	elif [ $BRAIN_CPUARCH = "armhf" ]; then
		sudo dpkg --add-architecture armhf
	fi
fi

# update APT Database
if [ $(uname) = "Linux" ]; then
	echo "APTキャッシュを更新しています..."
	sudo apt-get update
fi

# DONE.
echo -e "${GREEN_TEXT_COLOR}作業は終了しました。お疲れさまでした。${DEFAULT_TEXT_COLOR}"
echo "これ以降，SHARP Brain向けのdebパッケージをダウンロード(以下ではパッケージ名をhogeとします)するときには，次のコマンドをシェルに入力してください。"
echo "apt-get download hoge:armel \$(apt-cache depends hoge | grep Depends | gawk '{print \$2}' | sed 's/$/:armel/g')"

# END OF SCRIPT FILE.
