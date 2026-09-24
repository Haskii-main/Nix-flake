{ self, inputs, ... }: {

  # Setup module
  flake.nixosModules.laptopConfig = { config, pkgs, ... }:

  {
    # Import files
    imports =
      [
        self.nixosModules.laptopHardware
        self.nixosModules.niri
        self.nixosModules.laptopPkgs
        self.nixosModules.retro
      ];

    # Apply overlays
    nixpkgs.overlays = [
      inputs.self.overlays.default
    ];

    # Boot settings
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Host settings
    boot.kernelPackages = pkgs.linuxPackages_latest;
    networking.hostName = "Windhound";

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    networking.networkmanager.enable = true;

    # Enable Jackett
    services.jackett={
      enable = true;
      openFirewall = false;
    };

    # Set timezone
    time.timeZone = "Europe/Dublin";
    i18n.defaultLocale = "en_GB.UTF-8";

    # Regional formats
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

    # Graphics driver
    services.xserver.enable = true;

    # Desktop environment
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma";

    # Keyboard layout
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Printing service
    services.printing.enable = true;

    # Audio stack
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Bluetooth stack
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # User profile
    users.users."bryan" = {
      isNormalUser = true;
      description = "bryan";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kdePackages.kate
      ];
    };

    # System web/gaming
    programs.firefox.enable = true;
    programs.steam.enable = true;

    # Terminal shortcuts
    programs.bash.shellAliases = {
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
    };
    programs.zsh.shellAliases = {
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
    };

    # Nixpkgs environment
    nixpkgs.config.allowUnfree = true;
    environment.variables.EDITOR = "nvim";
    system.stateVersion = "26.05";
  };
}
