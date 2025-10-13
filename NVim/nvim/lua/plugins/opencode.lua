-- This file contains the configuration for the vim-be-good plugin in Neovim.

return {
  -- Plugin: opencode.nvim
  -- URL: https://github.com/sudo-tee/opencode.nvim
  "sudo-tee/opencode.nvim",
  config = function()
    --> Configuration for window resize error <--
    -- Track opencode's internal state during resize
    local in_resize = false
    local original_cursor_win = nil
    local opencode_filetypes = { "opencode_input", "opencode_output", "opencode_chat" }

    -- Temporarily move cursor away from opencode during resize
    local function temporarily_leave_opencode()
      local is_opencode, opencode_win
      if is_opencode and not in_resize then
        in_resize = true
        original_cursor_win = opencode_win

        -- Find a non-opencode window to switch to
        local target_win = nil
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype

          local is_opencode_ft = false
          for _, oft in ipairs(opencode_filetypes) do
            if ft == oft then
              is_opencode_ft = true
              break
            end
          end

          if not is_opencode_ft and vim.api.nvim_win_is_valid(win) then
            target_win = win
            break
          end
        end

        -- Switch to non-opencode window if found
        if target_win then
          vim.api.nvim_set_current_win(target_win)
          return true
        end
      end
      return false
    end

    -- Restore cursor to original opencode window
    local function restore_cursor_to_opencode()
      if in_resize and original_cursor_win and vim.api.nvim_win_is_valid(original_cursor_win) then
        -- Small delay to ensure resize is complete
        vim.defer_fn(function()
          pcall(vim.api.nvim_set_current_win, original_cursor_win)
          in_resize = false
          original_cursor_win = nil
        end, 50)
      end
    end

    -- Prevent duplicate windows cleanup
    local function cleanup_duplicate_opencode_windows()
      local seen_filetypes = {}
      local windows_to_close = {}

      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype

        -- Special handling for opencode panels
        for _, opencode_ft in ipairs(opencode_filetypes) do
          if ft == opencode_ft then
            if seen_filetypes[ft] then
              -- Found duplicate, mark for closing
              table.insert(windows_to_close, win)
            else
              seen_filetypes[ft] = win
            end
            break
          end
        end
      end

      -- Close duplicate windows
      for _, win in ipairs(windows_to_close) do
        if vim.api.nvim_win_is_valid(win) then
          pcall(vim.api.nvim_win_close, win, true)
        end
      end
    end

    -- Create autocmd group for resize fix
    vim.api.nvim_create_augroup("OpencodeResizeFix", { clear = true })

    -- Main resize handler for Resize
    vim.api.nvim_create_autocmd({ "VimResized" }, {
      group = "OpencodeResizeFix",
      callback = function()
        -- Move cursor away from opencode before resize processing
        local moved = temporarily_leave_opencode()

        if moved then
          -- Let resize happen, then restore cursor
          vim.defer_fn(function()
            restore_cursor_to_opencode()
            -- Force a clean redraw
            vim.cmd("redraw!")
          end, 100)
        end

        -- Cleanup duplicates after resize completes
        vim.defer_fn(cleanup_duplicate_opencode_windows, 150)
      end,
    })

    -- Prevent opencode from responding to scroll/resize events during resize
    vim.api.nvim_create_autocmd({ "WinScrolled", "WinResized" }, {
      group = "OpencodeResizeFix",
      pattern = "*",
      callback = function(args)
        local buf = args.buf
        if buf and vim.api.nvim_buf_is_valid(buf) then
          local ft = vim.bo[buf].filetype

          for _, opencode_ft in ipairs(opencode_filetypes) do
            if ft == opencode_ft then
              -- Prevent event propagation for opencode buffers during resize
              if in_resize then
                return true -- This should stop the event
              end
              break
            end
          end
        end
      end,
    })

    -- Additional cleanup on focus events
    vim.api.nvim_create_autocmd("FocusGained", {
      group = "OpencodeResizeFix",
      callback = function()
        -- Reset resize state on focus gain
        in_resize = false
        original_cursor_win = nil
        -- Clean up any duplicate windows
        vim.defer_fn(cleanup_duplicate_opencode_windows, 100)
      end,
    })
    --> Configuration for window resize error <--

    require("opencode").setup({
      prefered_picker = nil, -- 'telescope', 'fzf', 'mini.pick', 'snacks', if nil, it will use the best available picker
      default_global_keymaps = true, -- If false, disables all default global keymaps
      default_mode = "build", -- 'build' or 'plan' or any custom configured. @see [OpenCode Modes](https://opencode.ai/docs/modes/)
      config_file_path = nil, -- Path to opencode configuration file if different from the default `~/.config/opencode/config.json` or `~/.config/opencode/opencode.json`
      keymap = {
        editor = {
          ['<leader>oa'] = { 'toggle' }, -- Open opencode. Close if opened
          ['<leader>oi'] = { 'open_input' }, -- Opens and focuses on input window on insert mode
          ['<leader>oI'] = { 'open_input_new_session' }, -- Opens and focuses on input window on insert mode. Creates a new session
          ['<leader>oo'] = { 'open_output' }, -- Opens and focuses on output window
          ['<leader>ot'] = { 'toggle_focus' }, -- Toggle focus between opencode and last window
          ['<leader>oq'] = { 'close' }, -- Close UI windows
          ['<leader>os'] = { 'select_session' }, -- Select and load a opencode session
          ['<leader>op'] = { 'configure_provider' }, -- Quick provider and model switch from predefined list
          ['<leader>od'] = { 'diff_open' }, -- Opens a diff tab of a modified file since the last opencode prompt
          ['<leader>o]'] = { 'diff_next' }, -- Navigate to next file diff
          ['<leader>o['] = { 'diff_prev' }, -- Navigate to previous file diff
          ['<leader>oc'] = { 'diff_close' }, -- Close diff view tab and return to normal editing
          ['<leader>ora'] = { 'diff_revert_all_last_prompt' }, -- Revert all file changes since the last opencode prompt
          ['<leader>ort'] = { 'diff_revert_this_last_prompt' }, -- Revert current file changes since the last opencode prompt
          ['<leader>orA'] = { 'diff_revert_all' }, -- Revert all file changes since the last opencode session
          ['<leader>orT'] = { 'diff_revert_this' }, -- Revert current file changes since the last opencode session
          ['<leader>orr'] = { 'diff_restore_snapshot_file' }, -- Restore a file to a restore point
          ['<leader>orR'] = { 'diff_restore_snapshot_all' }, -- Restore all files to a restore point
          ['<leader>ox'] = { 'swap_position' }, -- Swap Opencode pane left/right
          ['<leader>opa'] = { 'permission_accept' }, -- Accept permission request once
          ['<leader>opA'] = { 'permission_accept_all' }, -- Accept all (for current tool)
          ['<leader>opd'] = { 'permission_deny' }, -- Deny permission request once
        },
        input_window = {
          ['<cr>'] = { 'submit_input_prompt', mode = { 'n', 'i' } }, -- Submit prompt (normal mode and insert mode)
          ['<esc>'] = { 'close' }, -- Close UI windows
          ['<C-c>'] = { 'stop' }, -- Stop opencode while it is running
          ['~'] = { 'mention_file', mode = 'i' }, -- Pick a file and add to context. See File Mentions section
          ['@'] = { 'mention', mode = 'i' }, -- Insert mention (file/agent)
          ['/'] = { 'slash_commands', mode = 'i' }, -- Pick a command to run in the input window
          ['<tab>'] = { 'toggle_pane', mode = { 'n', 'i' } }, -- Toggle between input and output panes
          ['<up>'] = { 'prev_prompt_history', mode = { 'n', 'i' } }, -- Navigate to previous prompt in history
          ['<down>'] = { 'next_prompt_history', mode = { 'n', 'i' } }, -- Navigate to next prompt in history
          ['<M-m>'] = { 'switch_mode' }, -- Switch between modes (build/plan)
        },
        output_window = {
          ['<esc>'] = { 'close' }, -- Close UI windows
          ['<C-c>'] = { 'stop' }, -- Stop opencode while it is running
          [']]'] = { 'next_message' }, -- Navigate to next message in the conversation
          ['[['] = { 'prev_message' }, -- Navigate to previous message in the conversation
          ['<tab>'] = { 'toggle_pane', mode = { 'n', 'i' } }, -- Toggle between input and output panes
          ['<C-i>'] = { 'focus_input' }, -- Focus on input window and enter insert mode at the end of the input from the output window
          ['<leader>oS'] = { 'select_child_session' }, -- Select and load a child session
          ['<leader>oD'] = { 'debug_message' }, -- Open raw message in new buffer for debugging
          ['<leader>oO'] = { 'debug_output' }, -- Open raw output in new buffer for debugging
          ['<leader>ods'] = { 'debug_session' }, -- Open raw session in new buffer for debugging
        },
      },
      ui = {
        position = "right", -- 'right' (default) or 'left'. Position of the UI split
        input_position = "bottom", -- 'bottom' (default) or 'top'. Position of the input window
        window_width = 0.33, -- Width as percentage of editor width
        input_height = 0.15, -- Input height as percentage of window height
        display_model = true, -- Display model name on top winbar
        display_context_size = true, -- Display context size in the footer
        display_cost = true, -- Display cost in the footer
        window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder", -- Highlight group for the opencode window
        output = {
          tools = {
            show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
          },
        },
      },
      context = {
        cursor_data = true, -- send cursor position and current line to opencode
        diagnostics = {
          info = false, -- Include diagnostics info in the context (default to false
          warn = true, -- Include diagnostics warnings in the context
          error = true, -- Include diagnostics errors in the context
        },
      },
      debug = {
        enabled = false, -- Enable debug messages in the output window
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },
  },
}
