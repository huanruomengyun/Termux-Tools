#!/data/data/com.termux/files/usr/bin/sh
function blue(){
	echo -e "\033[34m\033[01m$1\033[0m"
}
function green(){
	echo -e "\033[32m\033[01m$1\033[0m"
}
function red(){
	echo -e "\033[31m\033[01m$1\033[0m"
}

if [ -f $PREFIX/etc/tconfig ]; then
	red"您已安装 Tovow ，无需重复安装"
	red "如果您需要移除 Tovow，请输入 rm -rf $PREFIX/etc/tconfig"
	exit 1
fi

if [ ! -f $PREFIX/bin/git ]; then
	red -e "\033[31m\033[01m 警告，您并未安装 git \033[0m"
	blue -e "将自动安装 git..."
	blue -e "对于国内用户，未配置镜像源会导致安装时间极长"
	apt-get update && apt install git -y
	[[ ! -f $PREFIX/bin/git ]] && red "git 安装失败" && exit 1
fi

green "正在创建工作目录…"
mkdir -p $PREFIX/etc/tconfig

green "正在拉取远程仓库…"
git clone https://github.com.cnpmjs.org/QingxuMo/Tovow $PREFIX/etc/tconfig/main

green "正在修改远程仓库地址…"
cd $PREFIX/etc/tconfig/main
git remote set-url origin https://github.com/QingxuMo/Tovow

green "正在检查远程仓库地址…"
remote_status=$(git remote -v | grep "https://github.com/QingxuMo/Tovow")
[[ -z $remote_status ]] && red "远程仓库地址修改失败!\n请提交错误内容至开发者！"
cd $HOME

green "正在创建启动器…"
rm -f $PREFIX/bin/tconfig
cp $PREFIX/etc/tconfig/main/tconfig $PREFIX/bin/tconfig
chmod +x $PREFIX/bin/tconfig

if [ -f $PREFIX/bin/tconfig ]; then
	green "安装成功！请输入 tconfig 启动脚本！"
	exit 0
else
	red "安装失败！请提交错误内容至开发者！"
	red "错误：启动器安装失败"
	exit 1
fi
