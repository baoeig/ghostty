# Ghostty 终端配置

深色半透明主题 + Bloom 辉光 + 光标拖影。当前字体是 [Ioskeley Mono](https://github.com/ahatem/IoskeleyMono)（Iosevka × Berkeley），缺字时回退到 Maple Mono NF CN。

同一份 `config` 在 macOS 和 Linux 上都能用。不设置 `command`，启动哪个 shell 由 `$SHELL` / 系统用户项决定。

![Ghostty 终端截图](screen.png)

> 截图仍是 Maple Mono + 星空着色器时期的画面；实际配置见下方「当前生效」。

## 当前生效

| 项 | 值 |
|---|---|
| Ghostty | 1.3.2 tip |
| 字体 | `Ioskeley Mono` → `Maple Mono NF CN`，16pt |
| 光标 | block |
| 背景 | 透明度 `0.78` + blur |
| 着色器 | `bloom060`、`cursor_blaze_no_trail`、`cursor_smear` |
| 启动命令 | 默认 `$SHELL`（不自动进 tmux） |

## 安装

### 1. 安装 Ghostty

从 [ghostty.org](https://ghostty.org/) 下载。Linux 也可以用发行版包装（Arch `ghostty`、Fedora copr 等），GTK4 构建即可。

### 2. 安装字体

**macOS：** 从 [IoskeleyMono Releases](https://github.com/ahatem/IoskeleyMono/releases) 下载 `IoskeleyMono.zip`，双击装进「字体册」。中文回退：

```bash
brew install --cask font-maple-mono-nf-cn
```

**Linux：** 同样下载 zip，装到用户字体目录后刷新缓存：

```bash
mkdir -p ~/.local/share/fonts
unzip IoskeleyMono.zip -d ~/.local/share/fonts/IoskeleyMono
# 可选中文回退
# 从 https://github.com/subframe7536/maple-font/releases 装 Maple Mono NF CN
fc-cache -fv
fc-list | grep -i ioskeley
```

### 3. 部署配置

```bash
# 备份已有配置
mv ~/.config/ghostty ~/.config/ghostty.bak 2>/dev/null

# 克隆到配置目录
git clone https://github.com/BubblePtr/ghostty.git ~/.config/ghostty
```

**Linux 还要多一步**，避免共享配置里的 `Super+S/R/I` 抢走桌面环境快捷键：

```bash
ln -sf linux.conf ~/.config/ghostty/local.conf
```

`local.conf` 已被 gitignore。macOS 不用建这个文件。

重启 Ghostty。已打开的窗口：macOS 按 `Cmd+R`，Linux 按 `Ctrl+Shift+,`。

## 快捷键

`cmd` 和 `super` 在 Ghostty 里是同一个修饰键：macOS 是 Command，Linux 是 Super（Win 键）。

下面默认写 macOS 和弦。Linux 启用 `linux.conf` 之后，自定义项以括号为准。

### 窗口管理

| 操作 | 快捷键 |
|------|--------|
| 新建窗口 | `Cmd+N` |
| 关闭窗口 | `Cmd+Shift+W` |

### Tab 页

| 操作 | 快捷键 |
|------|--------|
| 新建 Tab | `Cmd+T` |
| 关闭 Tab | `Cmd+W` |
| 切换到上一个 Tab | `Cmd+Shift+[` |
| 切换到下一个 Tab | `Cmd+Shift+]` |
| 切换到第 N 个 Tab | `Cmd+1` ~ `Cmd+9` |

### 分屏 (Split)

| 操作 | 快捷键 |
|------|--------|
| 左右分屏 | `Cmd+D` |
| 上下分屏 | `Cmd+Shift+D` |
| 切换到上/下/左/右分屏 | `Cmd+Alt+方向键` |
| 关闭当前分屏 | `Cmd+W` |
| 等分所有分屏 | `Cmd+Shift+Enter` |

### 自定义快捷键

| 操作 | macOS | Linux（`local.conf` → `linux.conf`） |
|------|--------|--------|
| 快速终端 (Quick Terminal) | `Cmd+S` | `Ctrl+Shift+S` |
| 重载配置 | `Cmd+R` | `Ctrl+Shift+,`（系统默认） |
| 检查器 | `Cmd+I` | 系统默认（一般是 `Ctrl+Shift+I`） |

## Linux 上已知限制

这些不是配置写错，是 Ghostty 本身的平台差：

- **Quick Terminal 只支持 Wayland**，X11 上 `toggle_quick_terminal` 无效。
- **`global:` 全局快捷键只支持 macOS。** Linux 要在桌面环境里另绑（或用 `ghostty +toggle-quick-terminal`）。
- **`background-blur` 在 Linux 上只有 KDE Plasma 生效。** GNOME / Sway / Hyprland 会忽略强度，只留透明度。
- **`macos-option-as-alt`、`macos-icon` 在 Linux 上是空操作**，留在共享配置里没问题。
- **`quick-terminal-animation-duration` 只在 macOS 实现。**
- **同样 16pt，GTK 和 CoreText 的视觉大小不一样。** 到 Linux 后如果觉得偏大/偏小，在 `local.conf` 里单独改 `font-size`。
- **着色器两边都能跑**（macOS Metal / Linux OpenGL），只是性能和 gamma 可能略有差别。

## 着色器

当前启用：

- `bloom060.glsl` — 辉光（强度 0.60）
- `cursor_blaze_no_trail.glsl` — 光标闪烁
- `cursor_smear.glsl` — 光标拖影

`starfield-colors.glsl` 已关掉。`shaders/` 下还有 30+ 个可选着色器（CRT、矩阵雨、烟花等），编辑 `config` 注释/取消注释对应行即可切换。可用 `scripts/shader-showcase.sh` 轮播预览（macOS / Linux 都会重载配置）。

更多社区着色器：[ghostty-shaders](https://github.com/hackrmomo/ghostty-shaders)

