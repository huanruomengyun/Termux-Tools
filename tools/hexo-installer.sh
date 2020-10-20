#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Hexo one-click installation cript for Termux.
# Repository Address: https://github.com/QingxuMo/Termux-Hexo-installer
# Version: 0.2
# Copyright (c) 2020 Qingxu
#-----------------------------------
clear
pkg in nodejs-lts git vim nano openssh unzip -y
if network_check_sea; then
	green "网络连接正常，无需镜像源"
else
	green "是否更换 NPM 源为淘宝源? [y/n]"
	echo -en "Enter an option: "
	read npmtaobao
	case $npmtaobao in
		y)
			npm config set registry https://registry.npm.taobao.org ;;
		n)
			echo "Use default" ;;
		*)
			echo "输入无效,使用默认源" ;;
	esac
fi
npm install -g npm
npm install -g hexo-cli
green "请输入您想创建的 Hexo 博客文件夹名称 [必填]"
echo -en "\t\tEnter the name: "
read blogname
[[ -z "$blogname" ]] && red "未获取到博客文件夹名称，安装失败！" && exit 1
mkdir -p $HOME/$blogname
blog=$HOME/$blogname
hexo init $blog
npm install --prefix $blog hexo-deployer-git hexo-generator-feed hexo-generator-sitemap --save
echo "Hexo 已初始化并已安装基础模块，请勿重复进行 hexo init"
echo "Hexo 版本信息如下"
hexo version
echo "博客目录默认为 $blog"