{ self, inputs, ... }: {

  flake.nixosModules.laptopConfig = { config, pkgs, ... }:

  {
    imports =
      [ # Include the results of the hardware scan.
        self.nixosModules.laptopHardware
        self.nixosModules.niri
        self.nixosModules.laptopPkgs
      ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "Windhound";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Dublin";

    # Select internationalisation properties.
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

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma"; # Fixes the Niri vs Plasma conflict

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
    enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

    };

    #bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."bryan" = {
      isNormalUser = true;
      description = "bryan";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kdePackages.kate
      ];
    };

    # Install firefox.
    programs.firefox.enable = true;

    # Install Steam
    programs.steam.enable = true;

    #Bash and zsh shell aliases
    programs.bash.shellAliases = {
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
    };
    programs.zsh.shellAliases = {
      rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Sets custom Nixvim build as the default system-wide editor
    environment.variables.EDITOR = "nvim";

    system.stateVersion = "26.05";

  };

}
