-- This file contains the configuration for disabling specific Neovim plugins.

return {
  {
    -- Plugin: bufferline.nvim
    -- URL: https://github.com/akinsho/bufferline.nvim
    -- Description: A snazzy buffer line (with tabpage integration) for Neovim.
    "akinsho/bufferline.nvim",
    enabled = false, -- Disable this plugin
  },
  {
    -- Plugin para mejorar la experiencia de edición en Neovim
    -- URL: https://github.com/yetone/avante.nvim
    -- Description: Este plugin ofrece una serie de mejoras y herramientas para optimizar la edición de texto en Neovim.
    "yetone/avante.nvim",
    enabled = false,
  },
  {
    -- URL: https://github.com/CopilotC-Nvim/CopilotChat.nvim
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
  },
  {
    -- URL: https://github.com/mistricky/codesnap.nvim
    -- Issue: https://github.com/mistricky/codesnap.nvim/issues/153
    "mistricky/codesnap.nvim",
    enabled = false,
  },
  {
    "azorng/goose.nvim",
    enabled = false,
  },
}
