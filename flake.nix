{
  # Source dependencies
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Generate outputs
  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {
    # Module folder
    imports = [
      (inputs.import-tree ./modules)
    ];

    # Local packages
    perSystem = { config, pkgs, ... }: {
      # HolyC compiler
      packages.holyc-lang = pkgs.stdenv.mkDerivation rec {
        pname = "holyc-lang";
        version = "1.0.0";

        # Source code
        src = pkgs.fetchFromGitHub {
          owner = "Jamesbarford";
          repo = "holyc-lang";
          rev = "main";
          hash = "sha256-S9eRzHY2/1/tOLMZzWJSc2uyIIq5d4roG0jrHzDoTf0=";
        };

        # Toolchain dependencies
        nativeBuildInputs = with pkgs; [ cmake gnumake gcc ];

        # Skip setup
        dontUseCmakeConfigure = true;

        # Move binaries
        installPhase = ''
          mkdir -p $out/bin
          cp hcc $out/bin/
        '';
      };
    };

    # System attributes
    flake = {
      # Global overrides
      overlays.default = final: prev: {
        holyc-lang = inputs.self.packages.${final.stdenv.hostPlatform.system}.holyc-lang;
      };

      # Shell shortcuts
      flakeModules.terminal-alias = { config, pkgs, ... }: {
        # Bash configuration
        programs.bash.shellAliases = {
          rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
        };
        # Zsh configuration
        programs.zsh.shellAliases = {
          rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
        };
      };
    };
  };
}
