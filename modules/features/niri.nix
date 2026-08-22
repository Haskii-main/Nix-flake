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
        spawn-at-startup = [
          "${lib.getExe self'.packages.myNoctalia}"
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us,ua";

        layout.gaps = 5;

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

        binds = {
          "Mod+Return".spawn = [ "${lib.getExe self'.packages.kitty}" ];
          "Mod+B".spawn = [ "firefox" ];
          "Mod+Q".close-window = { };
          "Mod+D".spawn = ["discord"];
          "Mod+Shift+S".spawn = ["steam"];
          "Mod+S".spawn = [ "${lib.getExe self'.packages.myNoctalia}" "ipc" "call" "launcher" "toggle" ];
          "Mod+H".focus-column-left = { };
          "Mod+L".focus-column-right = { };
          "Mod+Alt+H".focus-monitor-left = { };
          "Mod+Alt+L".focus-monitor-right = { };
          "Mod+Shift+H".move-column-left = { };
          "Mod+Shift+L".move-column-right = { };
          "Mod+Ctrl+H".move-window-to-monitor-left = { };
          "Mod+Ctrl+L".move-window-to-monitor-right = { };
          "Mod+Comma".consume-window-into-column = { };
          "Mod+Period".expel-window-from-column = { };
          "Mod+F".maximize-column = { };
          "Mod+Shift+F".fullscreen-window = { };
        };
      };
    };
  };
}

