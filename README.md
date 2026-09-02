# cachyos-kernel-for-matebooke
修复matebook e在6.x以上内核的闪屏和6.12x以上的卡开机  
感谢Amer的补丁，来自https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/8992#note_3507233
### action编译需要抽奖，强烈建议去v3分支编译
action新老机器混合，90%几率会随机到不支持v4架构的虚拟机，极小概率随机到不支持v3的虚拟机，这时候会在从dockerfile创建容器过程中报错，因为v4程序不能在v3CPU执行，程序加了架构检测，检测AVX512（v4）和AVX2（v3），改为v3编译基本上99%成功，或者编译普通arch内核100%成功，那样就不需要抽奖了。
### 只编译linux-cachyos-bore-clang
自己改改就能编译其他的，但只能编译一个内核，action到时间会强制关机，实测只能编译一个半，所以舍弃了其他内核编译（通过find删除全部然后匹配排除项）和gcc编译（只是注释了）
