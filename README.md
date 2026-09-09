# My NixOS Config

A pure, dendritic NixOS configuration powered by flake-parts and import-tree.

---

## Core Components

* **Window Managers:** Niri and Noctalia WM
* **Text Editor:** Custom Nixvim build packed with the following integrations:

### Nixvim Plugins
<details>
<summary>Click to expand full plugin list</summary>

#### File Tree & Navigation
* NerdTree
* Fzf-Lua
* Telescope
* Ranger

#### Git & Source Control
* Vim-Fugitive
* LazyGit
* GitSigns

#### Core & Maintenance
* Which-Key
* Undotree
* Trouble
* Glow

#### LSP & Debugging
* **LSP Core:** Nix, C/C++, HolyC, HTML, Java, JavaScript, TypeScript, Haskell, Python, Rust, Scala
* **DAP:** Native Debug Adapter Protocol support
</details>

---

## Niri Keybinds

| Category | Keybinding | Action / Target |
| :--- | :--- | :--- |
| **Core Controls** | `Mod` + `Return` | Launch Kitty Terminal |
| | `Mod` + `B` | Launch Firefox Browser |
| | `Mod` + `Q` | Close Active Window |
| **TUI Software** | `Mod` + `E` | Launch custom Nixvim Editor |
| | `Mod` + `Shift` + `E` | Launch Ranger File Manager |
| **GUI Suite** | `Mod` + `D` | Launch Discord |
| | `Mod` + `Shift` + `S` | Launch Steam Station |
| | `Mod` + `M` | Launch Spotify |
| | `Mod` + `I` | Launch GIMP Editor |
| | `Mod` + `V` | Launch Kdenlive Video Suite |
| **Vim Navigation**| `Mod` + `H` / `L` | Focus Column Left / Right |
| | `Mod` + `J` / `K` | Focus Window Down / Up |
| **Layout Tweaks** | `Mod` + `Shift` + `H` / `L` | Move Column Left / Right |
| | `Mod` + `Shift` + `J` / `K` | Move Window Down / Up |
| | `Mod` + `,` / `.` | Consume into / Expel from Column |

---

## Extra Commands

To rebuild your local system environment, use the custom replication script:

```bash
rebuild-laptop
```
