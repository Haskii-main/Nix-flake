{ self, inputs, ... }: {

  flake.nixosModules.laptopConfig = { config, pkgs, ... }:

  {
    # Module Imports
    imports =
      [ 
        self.nixosModules.laptopHardware
        self.nixosModules.niri
        self.nixosModules.laptopPkgs
      ];

    # Flake Overlays
    nixpkgs.overlays = [ 
      inputs.self.overlays.default 
    ];

    # Boot Management
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Kernel Selection
    boot.kernelPackages = pkgs.linuxPackages_latest;
    networking.hostName = "Windhound";

    # Core Features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    networking.networkmanager.enable = true;

    # Localization
    time.timeZone = "America/Atlanta";
    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_IE.UTF-8";
      LC_IDENTIFICATION = "en_IE.UTF-8";
      LC_MEASUREMENT = "en_IE.UTF-8";
      LC_MONETARY = "en_IE.UTF-8";
      LC_NAME = "en_IE.UTF-8";
      LC_NUMERIC = "en_IE.UTF-8";
      LC_PAPER = "en_IE.UTF-8";
      LC_TELEPHONE = "en_IE.UTF-8";
      LC_TIME = "en_IE.UTF-8";
    };

    # Graphical Server
    services.xserver.enable = true;

    # Desktop Manager
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma";

    # Keymaps
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Printing
    services.printing.enable = true;

    # Sound System
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Hardware Drivers
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # User Provisioning
    users.users."bryan" = {
      isNormalUser = true;
      description = "bryan";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kdePackages.kate
      ];
    };

    # Core Apps
    programs.firefox.enable = true;
    programs.steam.enable = true;

    # Shell Configuration
    programs.bash.shellAliases = {
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
    };
    programs.zsh.shellAliases = {
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
    };

    # System Settings
    nixpkgs.config.allowUnfree = true;
    environment.variables.EDITOR = "nvim";
    system.stateVersion = "26.05";
  };
}

