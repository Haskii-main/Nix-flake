{
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

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {
    imports = [ 
      (inputs.import-tree ./modules) 
    ];

    perSystem = { config, pkgs, ... }: {
      # HolyC Compiler
      packages.holyc-lang = pkgs.stdenv.mkDerivation rec {
        pname = "holyc-lang";
        version = "1.0.0";

        src = pkgs.fetchFromGitHub {
          owner = "Jamesbarford";
          repo = "holyc-lang";
          rev = "main";
          hash = "sha256-S9eRzHY2/1/tOLMZzWJSc2uyIIq5d4roG0jrHzDoTf0=";
        };

        nativeBuildInputs = with pkgs; [ cmake gnumake gcc ];

        dontUseCmakeConfigure = true;

        installPhase = ''
          mkdir -p $out/bin
          cp hcc $out/bin/
        '';
      };
    };

    flake = {
      # Nixpkgs Overlay
      overlays.default = final: prev: {
        holyc-lang = inputs.self.packages.${final.stdenv.hostPlatform.system}.holyc-lang;
      };

      flakeModules.terminal-alias = { config, pkgs, ... }: {
        programs.bash.shellAliases = {
          rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
        };
        programs.zsh.shellAliases = {
          rebuild-laptop = "sudo nixos-rebuild switch --flake .#laptop";
        };
      };
    };
  };
}

