{ self, inputs, ... }: {

  # Setup module
  flake.nixosModules.desktopConfig = { config, pkgs, ... }:

  {
    # Import files
    imports =
      [
        self.nixosModules.desktopHardware
        self.nixosModules.niri
        self.nixosModules.desktopPkgs
        self.nixosModules.retro
      ];

    # Apply overlays
    nixpkgs.overlays = [
      inputs.self.overlays.default
    ];


  };
}
