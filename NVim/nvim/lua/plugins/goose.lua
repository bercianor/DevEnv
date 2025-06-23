return {
  "azorng/goose.nvim",
  -- keys = {
  --   { "<leader>ag", group = "Goose" },
  -- },
  config = function()
    require("goose").setup({
      default_global_keymaps = false, -- If false, disables all default global keymaps
      keymap = {
        global = {
          toggle = "<leader>agg", -- Open goose. Close if opened
          open_input = "<leader>agi", -- Opens and focuses on input window on insert mode
          open_input_new_session = "<leader>agI", -- Opens and focuses on input window on insert mode. Creates a new session
          open_output = "<leader>ago", -- Opens and focuses on output window
          toggle_focus = "<leader>agt", -- Toggle focus between goose and last window
          close = "<leader>agq", -- Close UI windows
          toggle_fullscreen = "<leader>agf", -- Toggle between normal and fullscreen mode
          select_session = "<leader>ags", -- Select and load a goose session
          goose_mode_chat = "<leader>agmc", -- Set goose mode to `chat`. (Tool calling disabled. No editor context besides selections)
          goose_mode_auto = "<leader>agma", -- Set goose mode to `auto`. (Default mode with full agent capabilities)
          configure_provider = "<leader>agp", -- Quick provider and model switch from predefined list
          diff_open = "<leader>agd", -- Opens a diff tab of a modified file since the last goose prompt
          diff_next = "<leader>ag]", -- Navigate to next file diff
          diff_prev = "<leader>ag[", -- Navigate to previous file diff
          diff_close = "<leader>agc", -- Close diff view tab and return to normal editing
          diff_revert_all = "<leader>agra", -- Revert all file changes since the last goose prompt
          diff_revert_this = "<leader>agrt", -- Revert current file changes since the last goose prompt
        },
        window = {
          submit = "<cr>", -- Submit prompt (normal mode)
          submit_insert = "<cr>", -- Submit prompt (insert mode)
          close = "<esc>", -- Close UI windows
          stop = "<C-c>", -- Stop goose while it is running
          next_message = "]]", -- Navigate to next message in the conversation
          prev_message = "[[", -- Navigate to previous message in the conversation
          mention_file = "@", -- Pick a file and add to context. See File Mentions section
          toggle_pane = "<tab>", -- Toggle between input and output panes
          prev_prompt_history = "<up>", -- Navigate to previous prompt in history
          next_prompt_history = "<down>", -- Navigate to next prompt in history
        },
      },
      ui = {
        window_width = 0.35, -- Width as percentage of editor width
        input_height = 0.15, -- Input height as percentage of window height
        fullscreen = false, -- Start in fullscreen mode (default: false)
        layout = "right", -- Options: "center" or "right"
        floating_height = 0.8, -- Height as percentage of editor height for "center" layout
        display_model = true, -- Display model name on top winbar
        display_goose_mode = true, -- Display mode on top winbar: auto|chat
      },
      providers = {
        groq = {
          "deepseek-r1-distill-llama-70b",
          "llama-3.1-8b-instant",
        },
      },
    })
  end,
  -- dependencies = {
  --   "nvim-lua/plenary.nvim",
  --   {
  --     "MeanderingProgrammer/render-markdown.nvim",
  --     opts = {
  --       anti_conceal = { enabled = false },
  --     },
  --   },
  -- },
}
