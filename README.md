# Ghostty 终端配置

深色半透明主题 + Bloom 辉光 + 光标拖影。当前字体是 [Ioskeley Mono](https://github.com/ahatem/IoskeleyMono)（Iosevka × Berkeley），缺字时回退到 Maple Mono NF CN。

同一份 `config` 在 macOS 和 [Omarchy](https://omarchy.org)（Arch + Hyprland）上都能用。不设置 `command`，启动哪个 shell 由 `$SHELL` / 系统用户项决定。

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

**macOS：** 从 [ghostty.org](https://ghostty.org/) 下载。

**Omarchy：** 不要自己 `pacman -S ghostty` 完事。用菜单 **Install → Terminal → Ghostty**（或 `omarchy-install-terminal ghostty`），这样会装包装、写 `xdg-terminals.list`，`Super+Return` 才会开到 Ghostty。已经装过的话，**Setup → Defaults → Terminal** 切过去。

### 2. 安装字体

主字体是 [Ioskeley Mono](https://github.com/ahatem/IoskeleyMono)，中文回退是 [Maple Mono NF CN](https://github.com/subframe7536/maple-font)。Ghostty 里箭头/盒线不对时，把 `IoskeleyMono.zip` 换成 `IoskeleyMono-Term.zip`。

**macOS：**

```bash
# Ioskeley Mono → ~/Library/Fonts
curl -fL -o /tmp/IoskeleyMono.zip \
  https://github.com/ahatem/IoskeleyMono/releases/latest/download/IoskeleyMono.zip
unzip -o /tmp/IoskeleyMono.zip -d /tmp/IoskeleyMono
cp /tmp/IoskeleyMono/*.ttf ~/Library/Fonts/

# 中文回退
brew install --cask font-maple-mono-nf-cn
```

**Omarchy：** 也可以之后用 `omarchy font set "Ioskeley Mono"`（它会 `sed` 本仓库 `config` 里的 `font-family` 行）。

```bash
mkdir -p ~/.local/share/fonts

curl -fL -o /tmp/IoskeleyMono.zip \
  https://github.com/ahatem/IoskeleyMono/releases/latest/download/IoskeleyMono.zip
unzip -o /tmp/IoskeleyMono.zip -d ~/.local/share/fonts/IoskeleyMono

curl -fL -o /tmp/MapleMono-NF-CN.zip \
  https://github.com/subframe7536/maple-font/releases/latest/download/MapleMono-NF-CN.zip
unzip -o /tmp/MapleMono-NF-CN.zip -d ~/.local/share/fonts/MapleMonoNF-CN

fc-cache -fv
fc-list | grep -iE 'ioskeley|maple'
```

### 3. 部署配置

```bash
# 备份已有配置
mv ~/.config/ghostty ~/.config/ghostty.bak 2>/dev/null

# 克隆到配置目录
git clone https://github.com/BubblePtr/ghostty.git ~/.config/ghostty
```

**Omarchy 还要多一步**，否则共享配置里的 `Cmd+S`（= Super+S）会和 Hyprland 的 scratchpad 抢键，而且配色跟不上桌面主题：

```bash
ln -sf omarchy.conf ~/.config/ghostty/local.conf
```

`linux.conf` 只是转到 `omarchy.conf` 的别名。`local.conf` 已被 gitignore。macOS 不用建这个文件。

然后把字号从 Mac 的 16pt 拉回 Omarchy 的默认刻度（12px 桌面字 → 终端 9pt）：

```bash
omarchy display text size
# 或指定：omarchy display text size 12
```

不要把 `font-size` / `font-family` 写进 `omarchy.conf`：`omarchy display text size` 和 `omarchy font set` 是直接 `sed` `config` 的。

重启 Ghostty。已打开的窗口：macOS 按 `Cmd+R`；Omarchy 按 `Ctrl+Shift+,`，或跑 `omarchy-restart-terminal`。

## 快捷键

`cmd` 和 `super` 在 Ghostty 里是同一个修饰键：macOS 是 Command，Omarchy 上 Super 归 Hyprland。

下面默认写 macOS 和弦。Omarchy 启用 `omarchy.conf` 之后，不要用 Super 做 Ghostty 自定义键。

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

| 操作 | macOS | Omarchy |
|------|--------|--------|
| 新开终端 | `Cmd+N` | `Super+Return`（Hyprland，不是 Ghostty） |
| 下拉/临时终端 | `Cmd+S`（Ghostty Quick Terminal） | `Super+S` scratchpad |
| 重载配置 | `Cmd+R` | `Ctrl+Shift+,` 或 `omarchy-restart-terminal` |
| 检查器 | `Cmd+I` | `Ctrl+Shift+I` |
| 复制/粘贴 | `Cmd+C` / `Cmd+V` | `Super+C` / `Super+V`（Omarchy 全局剪贴板） |
| 分屏 | `Cmd+D` | `Ctrl+Shift+O`（旁）/ `Ctrl+Shift+E`（下） |

## 对着 Omarchy 时要注意的

对照的是 [basecamp/omarchy](https://github.com/basecamp/omarchy) 当前的 `config/ghostty/config` 和手册热键。

- **先用 Omarchy 菜单装 Ghostty**，再克隆本仓库。只拷 `config` 不会写 `xdg-terminals.list`，`Super+Return` 可能还开着 Foot/Alacritty。
- **不要覆盖掉主题这一行的效果。** `omarchy.conf` 会再加载 `~/.local/state/omarchy/current/theme/ghostty.conf`，换主题（`Super+Ctrl+Shift+Space`）终端颜色才会跟着走。共享的 `ghostty-theme` 在 Omarchy 上会被盖掉，这是刻意的。
- **`Super+S` 是 scratchpad**，不是 Ghostty Quick Terminal。覆盖层会 `unbind` 共享配置里的 `cmd+s`。
- **`async-backend = epoll` 必开**，否则 Ghostty 在 Hyprland 上会明显卡（上游 discussion #3224）。
- **透明度交给 Hyprland**（`Super+Backspace`）。覆盖层把 `background-opacity` 设回 1，避免和桌面模糊叠两层。
- **字号不要写进 overlay。** Mac 上 16pt 正常；Omarchy 默认刻度是 9pt。用 `omarchy display text size` 改 `config` 里那一行。
- **`omarchy font set "…"` 会 sed 掉所有 `font-family =` 行**，两条回退字体会变成同一个家族。要回退就在改完字体后再手写第二行。
- **`macos-*` 在 Linux 上是空操作**，留在共享配置里没问题。
- 着色器（bloom / 光标）在 Hyprland 上能跑，只是吃 GPU；卡的话在 `config` 里注释掉 `custom-shader`。

## 着色器

当前启用：

- `bloom060.glsl` — 辉光（强度 0.60）
- `cursor_blaze_no_trail.glsl` — 光标闪烁
- `cursor_smear.glsl` — 光标拖影

`starfield-colors.glsl` 已关掉。`shaders/` 下还有 30+ 个可选着色器（CRT、矩阵雨、烟花等），编辑 `config` 注释/取消注释对应行即可切换。可用 `scripts/shader-showcase.sh` 轮播预览（macOS / Linux 都会重载配置）。

更多社区着色器：[ghostty-shaders](https://github.com/hackrmomo/ghostty-shaders)

