{ self, inputs, ... }: {

  flake.nixosModules.laptopPkgs = { pkgs, ... }: {    
    
    environment.systemPackages = with pkgs; [
      # systemPackages
      fastfetch
      blueman
      kitty
      ranger
      wget
      htop
      curl
      tree
      xwayland-satellite
      texliveFull
      fzf
      
      # programmingPackages
      git
      ghc
      python3
      rustc
      scala
      holyc-lang
      
      # gamingPackages
      discord
      
      # videomakingPackages
      kdePackages.kdenlive 
      gimp
      
      # miscPackages
      spotify
      linux-wallpaperengine
      mpv
      ffmpeg-headless
      lz4
      
      # Custom packages dynamically matching the host architecture
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNixvim
    ];
  };
}

