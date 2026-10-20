# dotfiles

macOS development environment: zsh + Oh My Zsh + Powerlevel10k, kitty + zellij, Neovim (NvChad), git + delta, and the Tokyo Night theme throughout.

No install script. Setup is three copy-paste steps.

## Setup

### 1. Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

This also installs the Xcode Command Line Tools, which provide `git`.

### 2. Clone and install packages

```sh
git clone https://github.com/lyubomir-bozhinov/dotfiles-public.git ~/dotfiles
brew bundle --file ~/dotfiles/Brewfile
```

### 3. Install the shell framework and copy the configs

```sh
git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/Aloxaf/fzf-tab.git ~/.oh-my-zsh/custom/plugins/fzf-tab
cp -R ~/dotfiles/home/. ~
mise install
```

> `cp -R` overwrites existing files with the same name (for example `~/.zshrc`). Back up anything you want to keep first.

Open **kitty**. The first Neovim launch installs its plugins.

## Optional

**Git identity and GitHub auth**

```sh
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
gh auth login
```

**Machine-specific settings.** Put tokens, work-only aliases and other private exports in `~/.zshrc.local`. `.zshrc` sources it if present; it is never committed.

**Docker.** `colima start` before using `docker`.

## What's included

| Path | Configures |
|---|---|
| `Brewfile` | CLI tools, toolchains, containers, apps, Hack Nerd Font |
| `home/.zprofile` | Homebrew environment |
| `home/.zshrc` | Oh My Zsh, plugins, fzf, zoxide, mise, aliases, zellij autostart |
| `home/.p10k.zsh` | Powerlevel10k prompt |
| `home/.config/kitty/` | kitty terminal + Tokyo Night theme |
| `home/.config/zellij/` | zellij multiplexer (compact layout, Tokyo Night) |
| `home/.config/nvim/` | Neovim on NvChad |
| `home/.config/git/`, `home/.config/delta/` | git defaults, delta side-by-side diffs |
| `home/.config/gh/` | GitHub CLI |
| `home/.config/mise/` | Language runtimes (Node, Python, Go, Java, Rust, Ruby, ...) |
| `home/.config/btop/` | btop resource monitor |
| `home/Library/Application Support/k9s/` | k9s Kubernetes UI + Tokyo Night skin |

## Updating

The configs are copies, not symlinks. After changing a file in `~`, copy it back into `home/` and commit. To pull new changes onto a machine, `git -C ~/dotfiles pull` and repeat the `cp -R` from step 3.

## Credits

- [Homebrew](https://brew.sh)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [fzf-tab](https://github.com/Aloxaf/fzf-tab)
- [Tokyo Night](https://github.com/folke/tokyonight.nvim) — kitty and delta themes from its `extras/`
- [Hack Nerd Font](https://www.nerdfonts.com/font-downloads)
- [kitty](https://sw.kovidgoyal.net/kitty/), [zellij](https://zellij.dev), [NvChad](https://nvchad.com), [delta](https://github.com/dandavison/delta), [mise](https://mise.jdx.dev), [k9s](https://k9scli.io)

## License

[MIT](LICENSE)
