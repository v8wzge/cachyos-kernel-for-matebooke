# cachyos-kernel-for-matebooke
修复matebook e在6.x以上内核的闪屏和6.12x以上的卡开机  
感谢Amer的补丁，来自https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/8992#note_3507233
### 只编译linux-cachyos-bore-clang
自己改改就能编译其他的，但只能编译一个内核，action到时间会强制关机，实测只能编译一个半，所以舍弃了其他内核编译（通过find删除全部然后匹配排除项）和gcc编译（只是注释了）
