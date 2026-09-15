{ self, inputs, ... }: {
  # Define module
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    # Configure Niri
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  # System outputs
  perSystem = { pkgs, lib, self', ... }: {
    # Custom package
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      v2-settings = true;

      settings = {
        # Autostart apps
        spawn-at-startup = [
          "${lib.getExe self'.packages.myNoctalia}"
        ];

        # Live wallpaper
        spawn-sh-at-startup = [
          "sleep 2 && ${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine --screen-root eDP-1 --scaling fill --assets-dir /home/bryan/.local/share/Steam/steamapps/common/wallpaper_engine/assets --dir /home/bryan/.local/share/Steam/steamapps/workshop/content/431960/3361183183"
        ];


        # XWayland path
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        # Keyboard layout
        input.keyboard.xkb.layout = "us,ua";

        # Window gaps
        layout = {
          gaps = 5;
          # Transparent canvas
          background-color = "rgba(0, 0, 0, 0.0)";
        };

        # Layer behavior
        layer-rules = [
          # Wallpaper layout
          {
            matches = [ { namespace = "^linux-wallpaperengine$"; } ];
            place-within-backdrop = true;
          }
        ];

        # Window rules
        window-rules = [
          {
            matches = [ { } ];
            open-maximized = true;
          }
          {
            matches = [ { app-id = "kitty"; } ];
            opacity = 0.85;
          }
          # Steam settings
          {
            matches = [ { app-id = "steam"; title = "^notificationtoasts_\\d+_desktop$"; } ];
            open-focused = false;
            open-floating = true;
            default-floating-position = _: {
              props = {
                x = 16;
                y = 16;
                relative-to = "bottom-right";
              };
            };
            block-out-from = "screencast";
          }
        ];

        # Keybinds mapping
        binds = {
          # Terminal shortcuts
          "Mod+Return".spawn = [ "${lib.getExe self'.packages.kitty}" ];
          "Mod+B".spawn = [ "firefox" ];
          "Mod+Q".close-window = { };

          # Launcher toggle
          "Mod+S".spawn = [ "${lib.getExe self'.packages.myNoctalia}" "ipc" "call" "launcher" "toggle" ];

          # TUI utilities
          "Mod+E".spawn = [ "${lib.getExe self'.packages.kitty}" "-e" "nvim" ];
          "Mod+Shift+E".spawn = [ "${lib.getExe self'.packages.kitty}" "-e" "ranger" ];

          # GUI apps
          "Mod+D".spawn = [ "discord" ];
          "Mod+Shift+S".spawn = [ "steam" ];
          "Mod+M".spawn = [ "spotify" ];
          "Mod+I".spawn = [ "gimp" ];
          "Mod+V".spawn = [ "kdenlive" ];

          # Navigation mapping
          "Mod+H".focus-column-left = { };
          "Mod+L".focus-column-right = { };
          "Mod+J".focus-window-down = { };
          "Mod+K".focus-window-up = { };
          "Mod+Alt+H".focus-monitor-left = { };
          "Mod+Alt+L".focus-monitor-right = { };

          # Move windows
          "Mod+Shift+H".move-column-left = { };
          "Mod+Shift+L".move-column-right = { };
          "Mod+Shift+J".move-window-down = { };
          "Mod+Shift+K".move-window-up = { };
          "Mod+Ctrl+H".move-window-to-monitor-left = { };
          "Mod+Ctrl+L".move-window-to-monitor-right = { };

          # Manage columns
          "Mod+Comma".consume-window-into-column = { };
          "Mod+Period".expel-window-from-column = { };

          # Size modes
          "Mod+F".maximize-column = { };
          "Mod+Shift+F".fullscreen-window = { };
          "Mod+R".switch-preset-column-width = { };

          # Resize window
          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          # Focus workspace
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          # Move workspace
          "Mod+Shift+1".move-window-to-workspace = 1;
          "Mod+Shift+2".move-window-to-workspace = 2;
          "Mod+Shift+3".move-window-to-workspace = 3;
          "Mod+Shift+4".move-window-to-workspace = 4;
          "Mod+Shift+5".move-window-to-workspace = 5;
          "Mod+Shift+6".move-window-to-workspace = 6;
          "Mod+Shift+7".move-window-to-workspace = 7;
          "Mod+Shift+8".move-window-to-workspace = 8;
          "Mod+Shift+9".move-window-to-workspace = 9;
        };
      };
    };
  };
}
