My Nixos Config


OVERVIEW
A pure dendritic Nixos Systemer with flake-parts and import-tree.

CORE COMPONENTS
Niri and Noctalia WM

Custom Nixvim build with
    #File Tree & Navigation
    NerdTree
    Fzf-Lua
    Telescope
    Ranger
    # Git + Source Control
    Vim-Fugitive
    LazyGit
    GitSigns
    #Core & Maintenance
    Which-Key
    Undotree
    Trouble
    Glow
    #LSP
    LSP Core
        Nix, C/C++, HolyC, HTML, Java&TypeScript, Haskell, Python, Rust, Scala, Java
    DAP

NIRI KEYBINDS
Category       | Keybinding       | Action / Target
---------------+------------------+-----------------------------------
Core Controls  | Mod + Return     | Launch Kitty Terminal

               | Mod + B          | Launch Firefox Browser
               | Mod + Q          | Close Active Window
---------------+------------------+-----------------------------------
TUI Software   | Mod + E          | Launch custom Nixvim Editor

               | Mod + Shift + E  | Launch Ranger File Manager
---------------+------------------+-----------------------------------
GUI Suite      | Mod + D          | Launch Discord

               | Mod + Shift + S  | Launch Steam Station
               | Mod + M          | Launch Spotify
               | Mod + I          | Launch GIMP Editor
               | Mod + V          | Launch Kdenlive Video Suite
---------------+------------------+-----------------------------------
Vim Navigation | Mod + H / L      | Focus Column Left / Right

               | Mod + J / K      | Focus Window Down / Up
---------------+------------------+-----------------------------------
Layout Tweaks  | Mod + Shift + H  | Move Column Left / Right

               | Mod + Shift + L  | Move Column Left / Right
               | Mod + Shift + J  | Move Window Down / Up
               | Mod + Shift + K  | Move Window Down / Up
               | Mod + , / .      | Consume into / Expel from Column

EXTRA COMMANDS
rebuild-laptop rebuilds the laptop configuration
