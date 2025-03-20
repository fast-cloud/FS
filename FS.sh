#!/bin/bash
 
# 下载 FS.zip 到 /tmp/ 目录
wget -P /tmp/ https://github.com/fast-cloud/FS/blob/main/FS.zip
 
# 检查下载是否成功
if [ $? -ne 0 ]; then
    echo "下载 FS.zip 失败"
    exit 1
fi
 
# 解压 /tmp/FS.zip 到 /tmp/
unzip /tmp/FS.zip -d /tmp
 
# 检查解压是否成功
if [ $? -ne 0 ]; then
    echo "解压 FS.zip 失败"
    exit 1
fi
 
# 删除旧文件（如果存在）
if [ -d /home/root/fanserver ]; then
    echo "/home/root/fanserver 文件夹存在，正在删除..."
    rm -rf /home/root/fanserver
fi
if [ -f /home/root/webgui/html/settings.html ]; then
    echo "/home/root/webgui/html/settings.html 文件存在，正在删除..."
    rm -f /home/root/webgui/html/settings.html
fi
if [ -f /home/root/webgui/js/settings.js ]; then
    echo "/home/root/webgui/js/settings.js 文件存在，正在删除..."
    rm -f /home/root/webgui/js/settings.js
fi
 
# 移动文件
if [ -d /tmp/FS/fanserver ]; then
    mv /tmp/FS/fanserver /home/root/
    echo "fanserver 文件夹已移动到 /home/root/"
else
    echo "解压后的 fanserver 文件夹不存在"
    exit 1
fi
if [ -f /tmp/FS/html/setting.html ]; then
    mv /tmp/FS/html/settings.html /home/root/webgui/html/
    echo "settings.html 文件已移动到 /home/root/webgui/html/"
else
    echo "解压后的 setting.html 文件不存在"
    exit 1
fi
if [ -f /tmp/FS/js/setting.js ]; then
    mv /tmp/FS/js/settings.js /home/root/webgui/js/
    echo "settings.js 文件已移动到 /home/root/webgui/js/"
else
    echo "解压后的 setting.js 文件不存在"
    exit 1
fi

# 添加启动脚本
if [ -f /home/root/webgui/js/settings.js ]; then
    echo "正在删除原启动脚本"
    rm -f /home/root/webgui/js/settings.js
fi
if [ -f /tmp/FS/start.sh ]; then
    mv /tmp/FS/start.sh /home/root/8080/
    echo "启动脚本已替换"
else
    echo "解压后的启动脚本不存在"
    exit 1
fi

# 设置权限
chmod 755 /home/root/8080/start.sh
chmod 755 /home/root/fanserver/start.sh

# 清理临时文件
rm -f /tmp/FS.zip
rm -rf /tmp/FS

#重启设备
echo "操作完成，重启设备中"
reboot
