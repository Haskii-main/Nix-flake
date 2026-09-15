{ ... }:

{
  perSystem = { pkgs, ... }: {
    packages.kitty = let
      kittyConfig = pkgs.writeText "kitty.conf" ''
        # --- Transparency Setup (Must initialize first) ---
        background_opacity         0.85
        dynamic_background_opacity yes

        # --- Font Setup ---
        font_family      RobotoMono Nerd Font
        bold_font        auto
        italic_font      auto
        bold_italic_font auto
        font_size        11.5

        # Disable ligatures for Roboto Mono to maximize raw rendering speed
        disable_ligatures always
        box_drawing_scale 0.001, 1, 1.5, 2

        # --- Window & UI Layout ---
        window_padding_width 14
        remember_window_size  no
        initial_window_width  950
        initial_window_height 600
        hide_window_decorations yes
        confirm_os_window_close 0

        # --- Mouse & Performance ---
        cursor_shape beam
        cursor_blink_interval 0.5
        scrollback_lines 8000
        copy_on_select yes
        repaint_delay 8
        input_delay 2
        sync_to_monitor yes

        # --- Bell Settings ---
        enable_audio_bell no
        window_alert_on_bell no

        # --- Color Scheme (Tokyo Night Deep) ---
        background            #1a1b26
        foreground            #c0caf5
        selection_background  #283457
        selection_foreground  #c0caf5
        url_color             #73daca
        cursor                #c0caf5
        cursor_text_color     #1a1b26

        # Tabs
        active_tab_background   #7aa2f7
        active_tab_foreground   #16161e
        inactive_tab_background #292e42
        inactive_tab_foreground #545c7e
        tab_bar_background      #15161e

        # Standard Terminal Colors
        color0 #15161e
        color8 #414868
        color1 #f7768e
        color9 #f7768e
        color2  #9ece6a
        color10 #9ece6a
        color3  #e0af68
        color11 #e0af68
        color4  #7aa2f7
        color12 #7aa2f7
        color5  #bb9af7
        color13 #bb9af7
        color6  #7dcfff
        color14 #7dcfff
        color7  #a9b1d6
        color15 #c0caf5
      '';
    in
    pkgs.writeShellScriptBin "kitty" ''
      exec ${pkgs.kitty}/bin/kitty --config "${kittyConfig}" "$@"
    '';
  };
}
