# Ghostty 终端配置

深色半透明主题 + Bloom 辉光 + 光标拖影。当前字体是 [Ioskeley Mono](https://github.com/ahatem/IoskeleyMono)（Iosevka × Berkeley）。

![Ghostty 终端截图](screen.png)

> 截图仍是 Maple Mono + 星空着色器时期的画面；实际配置见下方「当前生效」。

## 当前生效

| 项 | 值 |
|---|---|
| Ghostty | 1.3.2 tip |
| 字体 | `Ioskeley Mono`，16pt |
| 光标 | block |
| 背景 | 透明度 `0.78` + blur |
| 着色器 | `bloom060`、`cursor_blaze_no_trail`、`cursor_smear` |
| 启动命令 | 默认 shell（不再自动进 tmux） |

## 安装

### 1. 安装 Ghostty

从 [ghostty.org](https://ghostty.org/) 下载安装。

### 2. 安装字体

从 [IoskeleyMono Releases](https://github.com/ahatem/IoskeleyMono/releases) 下载 `IoskeleyMono.zip`（或需要图标时用 `IoskeleyMono-NerdFont.zip`），解压后双击安装到「字体册」。

中文回退可继续用 Maple Mono：

```bash
brew install --cask font-maple-mono-nf-cn
```

### 3. 部署配置

```bash
# 备份已有配置
mv ~/.config/ghostty ~/.config/ghostty.bak 2>/dev/null

# 克隆到配置目录
git clone https://github.com/BubblePtr/ghostty.git ~/.config/ghostty
```

重启 Ghostty，或在已打开的窗口里按 `Cmd+R` 重载配置。

## 快捷键

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

| 操作 | 快捷键 |
|------|--------|
| 快速终端 (Quick Terminal) | `Cmd+S` |
| 重载配置 | `Cmd+R` |
| 检查器 | `Cmd+I` |

在 tmux 里点开 URL：用 `Shift+Cmd+Click`（tmux 的 mouse mode 会吃掉普通点击）。

## 着色器

当前启用：

- `bloom060.glsl` — 辉光（强度 0.60）
- `cursor_blaze_no_trail.glsl` — 光标闪烁
- `cursor_smear.glsl` — 光标拖影

`starfield-colors.glsl` 已关掉。`shaders/` 下还有 30+ 个可选着色器（CRT、矩阵雨、烟花等），编辑 `config` 注释/取消注释对应行即可切换。可用 `scripts/shader-showcase.sh` 轮播预览。

更多社区着色器：[ghostty-shaders](https://github.com/hackrmomo/ghostty-shaders)
