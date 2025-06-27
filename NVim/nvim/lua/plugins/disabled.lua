-- This file contains the configuration for disabling specific Neovim plugins.

local disabled_plugins = {
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
}

local use_goose = true
if use_goose then
  table.insert(disabled_plugins, {
    "olimorris/codecompanion.nvim",
    enabled = false,
  })
else
  table.insert(disabled_plugins, {
    "azorng/goose.nvim",
    enabled = false,
  })
end

return disabled_plugins
