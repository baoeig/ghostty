#!/bin/bash
# Ghostty Shader 效果轮播展示脚本
# 用法: ./shader-showcase.sh [间隔秒数]
# 默认每 5 秒切换一个效果，Ctrl+C 退出后自动恢复原始配置

CONFIG="$HOME/.config/ghostty/config"
INTERVAL="${1:-5}"

# 要展示的 shader 效果（排除 bloom 变体、cursor、CRT 和负片效果）
SHADERS=(
    "animated-gradient-shader"
    "bloom060"
    "cubes"
    "dither"
    "drunkard"
    "fireworks-rockets"
    "fireworks"
    "gears-and-belts"
    "glitchy"
    "glow-rgbsplit-twitchy"
    "gradient-background"
    "inside-the-matrix"
    "just-snow"
    "matrix-hallway"
    "smoke-and-ghost"
    "sparks-from-fire"
    "spotlight"
    "starfield-colors"
    "starfield"
    "underwater"
    "water"
)

# 备份原始配置
cp "$CONFIG" "$CONFIG.showcase.bak"

# Reload the running Ghostty instance after rewriting config.
# macOS: send the default reload chord. Linux: systemd unit or SIGUSR2.
reload_config() {
    case "$(uname -s)" in
        Darwin)
            osascript -e 'tell application "System Events" to keystroke "r" using {command down}' 2>/dev/null \
                || osascript -e 'tell application "System Events" to keystroke "," using {command down, shift down}' 2>/dev/null
            ;;
        Linux)
            if systemctl --user reload app-com.mitchellh.ghostty.service 2>/dev/null; then
                return 0
            fi
            # Ghostty reloads config on SIGUSR2; any other signal can kill it.
            pkill -USR2 -x ghostty 2>/dev/null || true
            ;;
        *)
            echo "reload: unsupported OS $(uname -s); press your reload keybind" >&2
            ;;
    esac
}

restore() {
    echo ""
    echo "🔄 正在恢复原始配置..."
    cp "$CONFIG.showcase.bak" "$CONFIG"
    rm -f "$CONFIG.showcase.bak"
    reload_config
    echo "✅ 已恢复原始配置"
    exit 0
}

trap restore INT TERM

# 切换 shader 的函数：注释掉所有 custom-shader，启用指定的一个
switch_shader() {
    local shader_name="$1"
    sed -i '' 's/^custom-shader = shaders\//# custom-shader = shaders\//' "$CONFIG"
    sed -i '' "s|^# custom-shader = shaders/${shader_name}.glsl|custom-shader = shaders/${shader_name}.glsl|" "$CONFIG"
}

echo "🎨 Ghostty Shader 效果轮播展示"
echo "   间隔: ${INTERVAL} 秒 | 共 ${#SHADERS[@]} 个效果"
echo "   按 Ctrl+C 退出并恢复原始配置"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

for i in "${!SHADERS[@]}"; do
    shader="${SHADERS[$i]}"
    num=$((i + 1))
    echo ""
    echo "▶ [${num}/${#SHADERS[@]}] ${shader}"

    switch_shader "$shader"
    reload_config
    sleep "$INTERVAL"
done

echo ""
echo "🎬 展示完毕！"
restore
