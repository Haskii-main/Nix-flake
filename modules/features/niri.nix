{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      v2-settings = true;

      settings = {
        # Startup Applications
        spawn-at-startup = [
          "${lib.getExe self'.packages.myNoctalia}"
        ];

        # XWayland Layer
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        # Localization
        input.keyboard.xkb.layout = "us,ua";

        # Window Layout
        layout.gaps = 5;

        # Display Rules
        window-rules = [
          {
            matches = [ { } ];
            open-maximized = true;
          }
          {
            matches = [ { app-id = "kitty"; } ];
            opacity = 0.85;
          }
        ];

        # Action Bindings
        binds = {
          # Terminal & Browsers
          "Mod+Return".spawn = [ "${lib.getExe self'.packages.kitty}" ];
          "Mod+B".spawn = [ "firefox" ];
          "Mod+Q".close-window = { };

          # Core System Controls
          "Mod+S".spawn = [ "${lib.getExe self'.packages.myNoctalia}" "ipc" "call" "launcher" "toggle" ];

          # TUI Software
          "Mod+E".spawn = [ "${lib.getExe self'.packages.kitty}" "-e" "nvim" ];
          "Mod+Shift+E".spawn = [ "${lib.getExe self'.packages.kitty}" "-e" "ranger" ];

          # Graphical Core Apps
          "Mod+D".spawn = [ "discord" ];
          "Mod+Shift+S".spawn = [ "steam" ];
          "Mod+M".spawn = [ "spotify" ];
          "Mod+I".spawn = [ "gimp" ];
          "Mod+V".spawn = [ "kdenlive" ];

          # Core Vim Navigation
          "Mod+H".focus-column-left = { };
          "Mod+L".focus-column-right = { };
          "Mod+J".focus-window-down = { };
          "Mod+K".focus-window-up = { };
          "Mod+Alt+H".focus-monitor-left = { };
          "Mod+Alt+L".focus-monitor-right = { };

          # Layout Modification
          "Mod+Shift+H".move-column-left = { };
          "Mod+Shift+L".move-column-right = { };
          "Mod+Shift+J".move-window-down = { };
          "Mod+Shift+K".move-window-up = { };
          "Mod+Ctrl+H".move-window-to-monitor-left = { };
          "Mod+Ctrl+L".move-window-to-monitor-right = { };

          # Column Mechanics
          "Mod+Comma".consume-window-into-column = { };
          "Mod+Period".expel-window-from-column = { };

          # Sizing Overrides
          "Mod+F".maximize-column = { };
          "Mod+Shift+F".fullscreen-window = { };
          "Mod+R".switch-preset-column-width = { };

          # Fine Sizing
          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          # Workspace Indexing
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          # Workspace Migrations
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

