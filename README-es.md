[🇬🇧 English Version](README.md)

# DevEnv: Tu Entorno de Desarrollo Automatizado

DevEnv es un script integral diseñado para automatizar la configuración de un entorno de desarrollo moderno y robusto en sistemas Linux. Transforma una máquina recién instalada en un espacio de trabajo productivo, equipando al desarrollador con herramientas esenciales, un shell potente y un editor de código optimizado, todo preconfigurado para una experiencia de desarrollo fluida y eficiente.

Con DevEnv, puedes:

- Configurar rápidamente tu entorno de desarrollo en nuevas máquinas o después de reinstalaciones.
- Asegurar una configuración consistente de tus herramientas favoritas.
- Beneficiarte de configuraciones optimizadas para un flujo de trabajo más rápido.

## Instalación

La forma recomendada y más sencilla de instalar DevEnv es ejecutando el script `install` directamente desde el repositorio. Este comando manejará todas las dependencias necesarias, la instalación de Homebrew (Linuxbrew) si no está presente, las fuentes y la configuración de cada componente.

**Método Recomendado (Instalación por defecto en `~/.DevEnv`):**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bercianor/DevEnv/refs/heads/master/install)"
```

**Nota de Seguridad:** Es una buena práctica revisar el contenido de cualquier script antes de ejecutarlo directamente desde internet. Puedes inspeccionar el script `install` en el repositorio de DevEnv.

**Instalación Silenciosa:** Si prefieres que el script se ejecute sin pedir confirmación para cada componente, puedes usar:

```bash
SILENT=true /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bercianor/DevEnv/refs/heads/master/install)"
```

**Instalación Local (Clonando el repositorio):**

Si deseas clonar el repositorio primero o instalarlo en una ubicación diferente, asegúrate de que la carpeta se llame `DevEnv` y luego ejecuta el script `install`:

```bash
git clone https://github.com/bercianor/DevEnv /ruta/a/tu/DevEnv
cd /ruta/a/tu/DevEnv
./install
```

**Prerrequisitos:**

- Un sistema operativo basado en Linux (probado en Ubuntu/Debian).
- Acceso a internet.
- Permisos `sudo` para la instalación de ciertas dependencias y herramientas del sistema.

## Componentes y Características

DevEnv instala y configura las siguientes herramientas en tu sistema, en un orden optimizado para una integración adecuada:

1.  **Herramientas Esenciales del Sistema:**

    - **build-essential:** Paquetes necesarios para compilar software.
    - **curl:** Herramienta para transferir datos con URLs.
    - **file:** Utilidad para determinar el tipo de archivo.
    - **git:** Sistema de control de versiones distribuido.
    - **xclip:** Herramienta de línea de comandos para acceder al portapapeles de X.
    - **unzip:** Utilidad para descomprimir archivos ZIP.

2.  **Rust y Homebrew (Linuxbrew):**

    - **Rust:** Lenguaje de programación enfocado en la seguridad y el rendimiento.
    - **Homebrew (Linuxbrew):** El gestor de paquetes que simplifica la instalación de software en Linux.

3.  **Fuentes de Desarrollador:**

    - **FiraCode (Nerd Fonts):** Una fuente popular para programadores que incluye iconos y ligaduras para una mejor legibilidad del código.

    - **Personalización de Fuentes:** Puedes especificar una fuente Nerd Font y una versión diferentes configurando las variables de entorno `NERD_FONT_NAME` y `NERD_FONT_VERSION` antes de ejecutar el script de instalación. Por ejemplo:

      ```bash
      NERD_FONT_NAME="Hack" NERD_FONT_VERSION="v3.4.0" ./install
      ```

      La fuente predeterminada es `FiraCode` y la versión predeterminada es `v3.4.0`.

    - **Configuración de WezTerm:** Después de instalar una nueva fuente, recuerda configurar WezTerm para usarla editando su archivo de configuración (por ejemplo, `~/.config/wezterm/wezterm.lua`).

4.  **WezTerm:**

    - Un **emulador de terminal moderno y altamente configurable**, diseñado para alto rendimiento y una rica experiencia de usuario.

5.  **Zsh y Herramientas Relacionadas:**

    - **Zsh:** Un shell potente y flexible, con autocompletado avanzado y personalización.
    - **Carapace:** Completado de línea de comandos.
    - **Zoxide:** Una utilidad más inteligente para saltar directorios.
    - **Atuin:** Almacena, sincroniza y busca tu historial de comandos.
    - **Fzf:** Un buscador difuso de línea de comandos.
    - **Bat:** Un clon de `cat` con resaltado de sintaxis y números de línea.
    - **Lazygit:** Una interfaz de usuario de terminal para Git.
    - **Zsh-autosuggestions:** Sugerencias de comandos basadas en tu historial.
    - **Zsh-syntax-highlighting:** Resaltado de sintaxis para Zsh.
    - **Powerlevel10k:** Un tema increíblemente rápido y personalizable para Zsh.

6.  **Tmux:**

    - Un **multiplexador de terminal** que te permite ejecutar múltiples sesiones de terminal en una sola ventana, ideal para la multitarea y la persistencia de sesiones.

7.  **LazyVim:**

    - Una **configuración optimizada de Neovim** que lo transforma en un IDE potente y rápido, preconfigurado con plugins esenciales y atajos para el desarrollo.

8.  **OpenCode:**
    - El **cliente opencode**, una herramienta de desarrollo impulsada por IA para automatizar tareas y mejorar tu flujo de trabajo.

## Gestión de Configuraciones Personales (script `personal`)

DevEnv incluye un script `personal` dedicado a gestionar y centralizar tus archivos de configuración personal (dotfiles). Este script te permite mover configuraciones sensibles o personalizadas desde tu directorio `$HOME` a una ubicación versionada dentro del repositorio de DevEnv (`personal_config`), creando enlaces simbólicos para mantener la funcionalidad original.

El script `personal` maneja:

- **Git:** Archivos de configuración (`.gitconfig`, `.gitignore_global`).
- **SSH:** Configuración (`.ssh/config`).
- **OpenCode:** Archivos de configuración (`.config/opencoide`).
- **MCP Hub:** Archivo de configuración del servidor (`.config/mcphub/servers.json`).
- **Zsh:** Alias y directorios de configuración adicionales (`.zsh_alias`, `.zsh.d`).
- **WezTerm:** Módulos de configuración extra (`.config/wezterm/background.lua`).

Ten en cuenta que los archivos listados arriba son una selección y deben modificarse según tus necesidades individuales.

**¿Por qué usar el script `personal`?**
Este script es ideal para quienes desean mantener sus configuraciones personales bajo control de versiones junto con su entorno de desarrollo, facilitando la sincronización de estas configuraciones entre diferentes máquinas o después de reinstalaciones del sistema.

**Cómo ejecutar el script `personal`:**

```bash
./personal
```

Se recomienda ejecutar este script _después_ de la instalación inicial de DevEnv, o cuando desees centralizar nuevas configuraciones personales.

## Uso Post-Instalación

Después de que el script de instalación haya finalizado, recomendamos:

1.  **Reiniciar tu Terminal:** Abre una nueva ventana de terminal o reinicia tu sesión actual para asegurar que todos los cambios de entorno de shell (Zsh) y Homebrew surtan efecto.
2.  **Configuración de OpenCode:** Si es la primera vez que usas OpenCOde, es posible que necesites ejecutar `opencode auth login` para configurar tus credenciales.
3.  **Actualizar tu Entorno:** Para mantener tus herramientas actualizadas, puedes volver a ejecutar periódicamente el script `install`, o actualizar Homebrew manualmente:
    ```bash
    brew update
    brew upgrade
    ```

## Contribuciones

¡Las contribuciones a DevEnv son bienvenidas! Si deseas contribuir al proyecto, por favor, haz un fork del repositorio en GitHub y envía una solicitud de extracción (pull request).

## Licencia

DevEnv se distribuye bajo la [licencia](LICENSE) **GPLv3**.

## Agradecimientos

Quiero agradecer a [Gentleman Programmer](https://github.com/Gentleman-Programming) por la [idea](https://github.com/Gentleman-Programming/Gentleman.Dots) y la base para configurar mi propio entorno.
