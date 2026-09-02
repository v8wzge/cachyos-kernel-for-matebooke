# cachyos-kernel-for-matebooke
修复matebook e在6.x以上内核的闪屏和6.12x以上的卡开机  
感谢Amer的补丁，来自 [https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/8992#note_3507233]
### fork后自选内核分支，cachyos以全部支持
actions选择内核分支和编译方式，约3小时
### 做出的修改
makepkg-v4的dockerfile来自 [https://github.com/CachyOS/docker-makepkg] ,但停更失修，我修改一些脚本配置，适配action的v3/v4虚拟机抽奖环境，增加补丁等等  
不在使用官方脚本而是将脚本修改后加入action脚本  
不编译N卡驱动、zfs、r8125模块，这平板用不到，增加bbr3  
默认性能调度，不过主板有bug
