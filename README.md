# IPA_Re-sign
This is a Shell script for macOS that can re-sign ipa.

**Author:** iGhibli

**Date:** 2019/01/22



> **Description:** 一键自动重签ipa脚本。自动备存dis版本，自动生成debug版本。

> **Cautions:**
>
> - 下载下来的 `mobileprovision文件` 安装后必须拷贝一份放到`resign.sh`重签脚本的**同级目录**下。
> - 需要先将`resign.sh`重签脚本中的`XXXXXX`替换为**你的证书的十六进制串**（Signing Identity）。
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



##### PS: `sigh resign`关于重签名有时候失败或者无法安装的情况说明

1. 如果ipa 里面有除了系统之外的 `framework` 或者 `dylib` 的话，也需要先签名，不然也会导致签名后安装失败！至于 `sigh` 里面大致执行的脚本代码如下：

```shell
for framework in "$FRAMEWORKS_DIR"/*
do
	if [[ "$framework" == *.framework || "$framework" == *.dylib ]]
	then
		log "Resigning '$framework'"
		# Must not qote KEYCHAIN_FLAG because it needs to be unwrapped and passed to codesign with spaces
		# shellcheck disable=SC2086
		/usr/bin/codesign ${VERBOSE} ${KEYCHAIN_FLAG} -f -s "$CERTIFICATE" "$framework"
		checkStatus
	else
		log "Ignoring non-framework: $framework"
	fi
done
```

- 看得懂或者熟悉脚本的同学可以前往以下地址：

```shell
/usr/local/lib/ruby/gems/2.3.0/gems/sigh-2.0.1/lib/assets/resign.sh
```
> 版本号是根据自己当前 `sigh` 插件的版本号决定的。
>
> - 直接执行此脚本可以重签多 `target` 的 `ipa`：
> ```shell
> ./resign.sh YourApp.ipa "iPhone Distribution: YourCompanyOrDeveloperName" -p "bundel id"=.mobileprovision -p "bundel id"=.mobileprovision -p "bundel id"=.mobileprovision -p "bundel id"=.mobileprovision resignedYourApp.ipa
> ```



---