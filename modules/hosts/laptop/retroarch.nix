{ self, inputs, ... }: {

  flake.nixosModules.retro = { pkgs, ... }: {    
    
    environment.systemPackages = with pkgs; [
    (retroarch.withCores (cores: with cores; [
      beetle-psx-hw  # PlayStation 1
      bsnes          # Super Nintendo
      mgba           # Game Boy Advance
      mupen64plus    # Nintendo 64
      nestopia       # Nintendo Entertainment System
      genesis-plus-gx # Sega Genesis
      ]))
    ];  
  };
}

