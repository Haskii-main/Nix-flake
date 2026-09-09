{ inputs, ... }: {
  imports = [
    inputs.nixvim.flakeModules.default
  ];

  perSystem = { system, pkgs, ... }: {
    packages.myNixvim = inputs.nixvim.legacyPackages.${system}.makeNixvim {

      nixpkgs = {
        inherit pkgs;
        source = inputs.nixpkgs;
      };

      plugins = {
        # Core UI
        which-key.enable = true;
        web-devicons.enable = true;
        lualine.enable = true;
        indent-blankline.enable = true;
        noice.enable = true;
        notify.enable = true;

        # Syntax Parser
        treesitter = {
          enable = true;
          settings.ensure_installed = [
            "nix" "lua" "c" "cpp" "html" "haskell" "java" "python" "rust" "scala" "typescript" "markdown"
          ];
        };

        # Navigation Plugins
        telescope.enable = true;
        fzf-lua.enable = true;

        # Git Integration
        gitsigns.enable = true;
        lazygit.enable = true;
        undotree.enable = true;
        
        # Debugger Setup
        dap.enable = true;
        dap-ui.enable = true;
        dap-virtual-text.enable = true;

        # Language Server Protocol
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            ccls.enable = true;
            html.enable = true;
            ts_ls.enable = true;
            hls = {
              enable = true;
              installGhc = false;
            };
            pyright.enable = true;
          };
        };

        # Diagnostic Tools
        fidget.enable = true;
        trouble.enable = true;

        # Autocompletion Layout
        lspkind = {
          enable = true;
          cmp.enable = true;
        };

        # Rust & Scale Frameworks
        rustaceanvim.enable = true;

        # Code Formatters
        none-ls = {
          enable = true;
          enableLspFormat = false;
          sources = {
            formatting = {
              alejandra.enable = true;
              black.enable = true;
              google_java_format.enable = true;
            };
          };
        };
      };

      # Appearance Settings
      colorschemes.tokyonight = {
        enable = true;
        settings.style = "night"; 
      };

      # Global Options
      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        termguicolors = true;
        smartindent = true;
      };

      # Completion Sources
      plugins.cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) vim.fn['vsnip#anonymous'](args.body) end";
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
            { name = "treesitter"; }
            { name = "vsnip"; }
            { name = "dap"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };

      # Custom Extension Array
      extraPlugins = with pkgs.vimPlugins; [
        vim-vsnip
        ranger-nvim
        glow-nvim
        nvim-autopairs
        nvim-lightbulb
        lsp_signature-nvim
        nvim-ts-autotag
        nvim-jdtls
        nvim-metals
        vim-fugitive
        nerdtree # FIXED: Shifted safely down out of core option blocks into extraPlugins
      ];

      # HolyC File Type Mapping
      filetype = {
        extension = {
          hc = "c";
        };
      };

      # Extra Configuration Blocks
      extraConfigLua = ''
        require('nvim-autopairs').setup({})
        require('nvim-ts-autotag').setup({})
        require('lsp_signature').setup({})
        require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
        require('glow').setup({})
        vim.api.nvim_set_keymap("n", "<leader>r", ":Ranger<CR>", {silent = true, noremap = true})
      '';
    };
  };
}

