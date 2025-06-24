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
