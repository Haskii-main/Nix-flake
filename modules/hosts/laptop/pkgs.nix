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
      
      # programmingPackages
      git
      ghc
      python3
      rustc
      scala
      
      # gamingPackages
      steam
      discord
      
      # videomakingPackages
      kdePackages.kdenlive 
      gimp
      
      # miscPackages
      spotify
      
      # Custom packages dynamically matching the host architecture
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNixvim
    ];
  };
}

