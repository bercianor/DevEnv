[🇪🇸 Versión en Español](README-es.md)

# DevEnv: Your Automated Development Environment

DevEnv is a comprehensive script designed to automate the setup of a modern and robust development environment on Linux systems. It transforms a freshly installed machine into a productive workspace, equipping the developer with essential tools, a powerful shell, and an optimized code editor, all pre-configured for a smooth and efficient development experience.

With DevEnv, you can:
- Quickly set up your development environment on new machines or after reinstalls.
- Ensure a consistent configuration of your favorite tools.
- Benefit from optimized configurations for a faster workflow.

## Installation

The recommended and simplest way to install DevEnv is by running the `install` script directly from the repository. This command will handle all necessary dependencies, the installation of Homebrew (Linuxbrew) if not present, fonts, and the configuration of each component.

**Recommended Method (Default installation to `~/.DevEnv`):**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bercianor/DevEnv/refs/heads/main/install)"
```

**Security Note:** It's good practice to review the content of any script before executing it directly from the internet. You can inspect the `install` script in the DevEnv repository.

**Silent Installation:** If you prefer the script to run without prompting for confirmation for each component, you can use:

```bash
SILENT=true /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bercianor/DevEnv/refs/heads/main/install)"
```

**Local Installation (Cloning the repository):**

If you wish to clone the repository first or install it in a different location, ensure the folder is named `DevEnv` and then run the `install` script:

```bash
git clone https://github.com/bercianor/DevEnv /path/to/your/DevEnv
cd /path/to/your/DevEnv
./install
```

**Prerequisites:**
- A Linux-based operating system (tested on Ubuntu/Debian).
- Internet access.
- `sudo` permissions for the installation of certain system dependencies and tools.

## Components and Features

DevEnv installs and configures the following tools on your system, in an optimized order for proper integration:

1.  **Essential System Tools:**
    *   **build-essential:** Packages required for compiling software.
    *   **curl:** Tool for transferring data with URLs.
    *   **file:** Utility to determine file type.
    *   **git:** Distributed version control system.
    *   **xclip:** Command-line tool to access the X clipboard.
    *   **unzip:** Utility to decompress ZIP files.

2.  **Rust and Homebrew (Linuxbrew):**
    *   **Rust:** Programming language focused on safety and performance.
    *   **Homebrew (Linuxbrew):** The package manager that simplifies software installation on Linux.

3.  **Developer Fonts:**
    *   **FiraCode (Nerd Fonts):** A popular font for programmers that includes icons and ligatures for better code readability.

4.  **WezTerm:**
    *   A **modern and highly configurable terminal emulator**, designed for high performance and a rich user experience.

5.  **Zsh and Related Tools:**
    *   **Zsh:** A powerful and flexible shell, with advanced autocompletion and customization.
    *   **Carapace:** Command-line completions.
    *   **Zoxide:** A smarter directory jumping utility.
    *   **Atuin:** Stores, syncs, and searches your command history.
    *   **Fzf:** A command-line fuzzy finder.
    *   **Bat:** A `cat` clone with syntax highlighting and line numbers.
    *   **Lazygit:** A terminal UI for Git.
    *   **Zsh-autosuggestions:** Command suggestions based on your history.
    *   **Zsh-syntax-highlighting:** Syntax highlighting for Zsh.
    *   **Powerlevel10k:** An incredibly fast and customizable theme for Zsh.

6.  **Tmux:**
    *   A **terminal multiplexer** that allows you to run multiple terminal sessions in a single window, ideal for multitasking and session persistence.

7.  **LazyVim:**
    *   An **optimized Neovim configuration** that transforms it into a powerful and fast IDE, pre-configured with essential plugins and shortcuts for development.

8.  **Goose:**
    *   The **Goose client**, an AI-powered development tool to automate tasks and enhance your workflow.

## Managing Personal Configurations (`personal` script)

DevEnv includes a `personal` script dedicated to managing and centralizing your personal configuration files (dotfiles). This script allows you to move sensitive or personalized configurations from your `$HOME` directory to a versioned location within the DevEnv repository (`personal_config`), creating symbolic links to maintain original functionality.

The `personal` script handles:
- **Git:** Configuration files (`.gitconfig`, `.gitignore_global`).
- **SSH:** Configuration (`.ssh/config`).
- **Goose:** Configuration and memory files (`.config/goose/config.yaml`, `.config/goose/memory`).
- **MCP Hub:** Server configuration file (`.config/mcphub/servers.json`).
- **Zsh:** Aliases and additional configuration directories (`.zsh_alias`, `.zsh.d`).
- **WezTerm:** Extra configuration modules (`.config/wezterm/background.lua`).

Please note that the files listed above are a selection and should be modified according to your individual needs.

**Why use the `personal` script?**
This script is ideal for those who want to keep their personal configurations under version control alongside their development environment, facilitating the synchronization of these configurations between different machines or after system reinstalls.

**How to run the `personal` script:**

```bash
./personal
```

It is recommended to run this script *after* the initial DevEnv installation, or when you want to centralize new personal configurations.

## Post-Installation Usage

After the installation script has finished, we recommend:

1.  **Restart your Terminal:** Open a new terminal window or restart your current session to ensure all shell (Zsh) and Homebrew environment changes take effect.
2.  **Goose Configuration:** If this is your first time using Goose, you may need to run `goose configure` to set up your credentials.
3.  **Update your Environment:** To keep your tools up-to-date, you can periodically re-run the `install` script, or update Homebrew manually:
    ```bash
    brew update
    brew upgrade
    ```

## License

DevEnv is distributed under the **GPLv3** [license](LICENSE).

## Contributing

Contributions to DevEnv are welcome! If you'd like to contribute to the project, please fork the repository on GitHub and submit a pull request.

## Thanks

I want to thank [Gentleman Programmer](https://github.com/Gentleman-Programming) for the [idea](https://github.com/Gentleman-Programming/Gentleman.Dots) and the foundation to set up my own environment.
