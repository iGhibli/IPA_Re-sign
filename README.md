# IPA_Re-sign
This is a Shell script for macOS that can re-sign ipa.

**Author:** iGhibli

**Date:** 2019/01/22



> **Description:** 一键自动重签ipa脚本。自动备存dis版本，自动生成debug版本。

> **Cautions:** 下载下来的 `mobileprovision文件` 安装后必须拷贝一份放到`resign.sh`重签脚本的**同级目录**下。
>
> - App Store下载的包，需要先 [iOS逆向](http://iosre.com/) 砸壳，才能重签。

### 一、环境配置

- 安装`homebrew`
  - [安装链接](https://brew.sh/)。
  - 安装命令：`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
- 安装`ruby`
  - 安装命令：`brew install ruby`
- 安装`sigh`
  - 安装命令：`sudo gem install sigh`

### 二、执行`resign.sh`脚本

- 直接运行命令：`./resign.sh xxx_dir/xxx.ipa`

> **Cautions:** 脚本执行时传入参数需为ipa文件的完整绝对路径。