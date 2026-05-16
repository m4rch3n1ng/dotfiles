-- hyprland lua config
-- wiki https://wiki.hypr.land/Configuring/Start/

-- <monitors />
-- wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1,
})

-- <startup exec />
-- wiki https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
    hl.exec_cmd("$HOME/.config/hypr/xdg-portal-hyprland.sh")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- stores only image data
    hl.exec_cmd("libinput-gestures-setup restart")
    hl.exec_cmd("ydotoold")
end)

-- <startup env />
-- wiki https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_THEME", "default")
hl.env("XCURSOR_SIZE", "24")

-- <general config />
-- wiki https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        border_size = 2,

        col = {
            active_border   = "rgb(cdd6f4)",
            inactive_border = "rgb(595959)",
        },

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,

        blur = {
            enabled   = true,
            size      = 7,
            passes    = 2,
        },

        shadow = {
            enabled      = true,
            color        = "rgba(1a1a1aee)",
        },
    },

    animations = {
        enabled = true,
    },
})

-- <animations />
-- wik https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("myBezier",   { type = "bezier", points = { {0.05, 0.9},    {0.1, 1.05}    } })
-- hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
-- hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
-- hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
-- hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
-- hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
-- hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 10, bezier = "myBezier" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 7, bezier = "myBezier", style = "popin 87%" })
-- hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 7, bezier = "myBezier" })
-- hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 6, bezier = "myBezier" })
-- hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- <dwindle layout />
-- wiki https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        preserve_split = true,
        special_scale_factor = true,
    },
})

-- <master layout />
-- wiki https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})

-- <scrolling layout />
-- wiki https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

-- <misc />
hl.config({
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
    },

    cursor = {
      enable_hyprcursor = false,
    },
})

-- <input />
hl.config({
    input = {
        kb_layout  = "de",
       	kb_file    = "~/.config/keymap/may.xkb",

        accel_profile = "flat",
        follow_mouse  = 1,
        scroll_method = "2fg",

        sensitivity = 0.7,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.5,
            clickfinger_behavior = true,
            tap_and_drag = true,
            drag_lock = 0,
        },
    },
})

-- <gestures />
hl.config({
    gestures = {
       	workspace_swipe_distance = 1200,
       	workspace_swipe_min_speed_to_force = 0,
       	workspace_swipe_cancel_ratio = 0.2,
       	workspace_swipe_direction_lock = false,
    }
})

hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace"
})

-- <keybindings />
local mainMod = "SUPER"

-- system
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("~/.config/wofi/power-menu.sh"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("~/.config/wofi/keymap.sh"))
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exit())

-- window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- window focus
hl.bind(mainMod .. " + TAB",         hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + left",        hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right",       hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",          hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",        hl.dsp.focus({ direction = "down" }))

-- programs
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("librewolf"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("librewolf --private-window"))

-- screenshots, colorpicker, etc
hl.bind(mainMod .. "+ S", hl.dsp.exec_cmd("hyprshot -m window --raw | swappy -f -")) -- take a screenshot
hl.bind(mainMod .. "+ G", hl.dsp.exec_cmd("hyprshot -m window -m active --raw | swappy -f -")) -- take a screenshot
hl.bind(mainMod .. "+ SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --raw | swappy -f -")) -- take a screenshot
hl.bind(mainMod .. "+ SHIFT + C", hl.dsp.exec_cmd("hyprpicker | wl-copy")) -- launch colorpicker
hl.bind(mainMod .. "+ V", hl.dsp.exec_cmd("~/.config/wofi/cliphist.sh")) -- launch clipboard

-- workspace switching
for key = 0, 9 do
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = key + 1 }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = key + 1 }))
end

-- scratch workspace
hl.bind(mainMod .. " + X",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special:magic" }))

-- mouse scroll workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- mouse resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- volume
hl.bind("XF86AudioMute",                hl.dsp.exec_cmd("pamixer -t"),              { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume",         hl.dsp.exec_cmd("pamixer -i 5"),            { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",         hl.dsp.exec_cmd("pamixer -d 5"),            { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioMute",        hl.dsp.exec_cmd("pamixer --default-source -t"),              { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer --default-source -i 5"),            { locked = true, repeating = true })
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer --default-source -d 5"),            { locked = true, repeating = true })
hl.bind("XF86AudioMedia",               hl.dsp.exec_cmd("pamixer --set-volume 45"), { locked = true, repeating = true })

-- brightness
hl.bind("XF86MonBrightnessUp",          hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",        hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl set 1%+"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl set 1%-"), { locked = true, repeating = true })

-- mpris
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


-- <windows and workspaces />
-- wiki https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- wiki https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.window_rule({
    -- fix some dragging issues with xwayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "center",
    match = { class = "." },

    center = true
})

hl.window_rule({
    name = "float",
    match = {
        class = "^("
            .. "7zFM|7zfm|blueman-manager|com.nextcloud.desktopclient.nextcloud|pavucontrol|"
            .. "thunar|Thunar|org.gnome.Nautilus|com.system76.CosmicFiles|"
            .. "Steam|steam|Steam setup"
            .. ")$",
    },

    float = true,
    opacity = "0.8 0.8"
})

hl.window_rule({
    name = "chromium",
    match = {
        class = "^(chromium)$",
        title = "^(Save File|Open File|Open Files)$"
    },

    float = true,
    opacity = "0.8 0.8"
})

hl.window_rule({
    name = "librewolf",
   	match = {
   	    class = "LibreWolf",
       	title = "negative:.*LibreWolf.*",
    },

   	float = true,
})

hl.window_rule({
    name = "librewolf extensions",
   	match = {
   	    class = "LibreWolf",
       	title = "Extension:.*",
    },

   	float = true,
})

hl.window_rule({
    name = "librewolf picture in picture",
   	match = {
   	    class = "LibreWolf",
       	title = "Picture-in-Picture",
    },

   	move = { 1400, 975 },
   	size = { 720, 420 }
})

hl.window_rule({
    name = "live captions",
    match = { class = "^(net.sapples.LiveCaptions)$" },

    float = true,
    opacity = "0.8 0.8",
    move = { 695, 1335 },
})

hl.window_rule({
    name = "file manager",
    match = { class = "^(thunar|Thunar|org.gnome.Nautilus)$" },

    size = { 1000, 700 }
})
