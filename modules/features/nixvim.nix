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
        which-key.enable = true;
        web-devicons.enable = true;
        lualine.enable = true;
        indent-blankline.enable = true;
        noice.enable = true;
        notify.enable = true;

        treesitter = {
          enable = true;
          settings.ensure_installed = [
            "nix" "lua" "c" "cpp" "html" "haskell" "java" "python" "rust" "scala" "typescript" "markdown"
          ];
        };

        
        telescope.enable = true;
        gitsigns.enable = true;
        lazygit.enable = true;
        undotree.enable = true;
        
        dap = {
          enable = true;
          extensions = {
            dap-ui.enable = true;
            dap-virtual-text.enable = true;
          };
        };

        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            ccls.enable = true;
            html.enable = true;
            ts_ls.enable = true;

            hls.enable = true;
            pyright.enable = true;
          };
        };

        fidget.enable = true;
        trouble.enable = true;

        lspkind = {
          enable = true;
          cmp.enable = true;
        };


        rustaceanvim.enable = true;

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

      colorschemes.tokyonight = {
        enable = true;
        settings.style = "night"; 
      };

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        termguicolors = true;
        smartindent = true;
      };

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
      ];

      extraConfigLua = ''
        -- Initialize Autopairs
        require('nvim-autopairs').setup({})

        -- Initialize HTML Auto-tagging
        require('nvim-ts-autotag').setup({})

        -- Initialize Signature Hints
        require('lsp_signature').setup({})

        -- Initialize Lightbulb Code Actions
        require('nvim-lightbulb').setup({ autocmd = { enabled = true } })

        -- Initialize Markdown Glow Preview
        require('glow').setup({})

        -- Custom Ranger activation map layout command (<leader> + r)
        vim.api.nvim_set_keymap("n", "<leader>r", ":Ranger<CR>", {silent = true, noremap = true})
      '';
    };
  };
}
