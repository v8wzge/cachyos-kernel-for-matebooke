#!/usr/bin/env bash

## 1. 全局配置修改
## zfs
# find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_zfs:=no/_build_zfs:=yes/" {}
## v4架构
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_processor_opt:=/_processor_opt:=GENERIC_V4/" {}
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_auto_optimization:=yes/_use_auto_optimization:=no/" {}
## N卡
# find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_nvidia_open:=no/_build_nvidia_open:=yes/" {}
## r8125
# find . -name "PKGBUILD" | xargs -I {} sed -i "s/_build_r8125:=no/_build_r8125:=yes/" {}
## bbr3
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_tcp_bbr3:=no/_tcp_bbr3:=yes/" {}
## 默认性能（有问题，不管开不开cpu都锁在5w）
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_per_gov:=no/_per_gov:=yes/" {}

## gcc内核不用lto
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto:=thin/_use_llvm_lto:=none/" {}

## 2. GCC v4 Kernel 编译
files=$(find . -name "PKGBUILD")
for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v $PWD:/pkg pttrr/docker-makepkg-v4
    docker rm kernelbuild
    cd ..
done

## 3. LLVM ThinLTO v4 Kernel 编译
find . -name "PKGBUILD" | xargs -I {} sed -i "s/_use_llvm_lto:=none/_use_llvm_lto:=thin/" {}

files=$(find . -name "PKGBUILD")
for f in $files
do
    d=$(dirname $f)
    cd $d
    time docker run --name kernelbuild -e EXPORT_PKG=1 -e SYNC_DATABASE=1 -e CHECKSUMS=1 -v $PWD:/pkg pttrr/docker-makepkg-v4
    docker rm kernelbuild
    cd ..
done

## 4. 移动内核到仓库并更新
echo "move kernels to the repo"
mv */*-x86_64_v4.pkg.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v4/cachyos-v4/
RUST_LOG=trace repo-manage-util -p cachyos-v4 update
## Ensure that repo-add/repoctl catches all new packages
RUST_LOG=trace repo-manage-util -p cachyos-v4 update
