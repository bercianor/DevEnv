vim.keymap.set("n", "<leader>k", "", { desc = "NeOrg" })
vim.keymap.set(
  "n",
  "<leader>kn",
  "<Plug>(neorg.dirman.new-note)",
  { desc = "Create a new .norg file to take notes in" }
)
vim.keymap.set("n", "<leader>kw", "<cmd>Neorg workspace notes<CR>", { desc = "Enter notes Workspace" })
vim.keymap.set("n", "<leader>ki", "<cmd>Neorg index<CR>", { desc = "Open index" })
vim.keymap.set("n", "<leader>kj", "<cmd>Neorg journal<CR>", { desc = "Open journal" })
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "norg",
  callback = function()
    vim.keymap.set("n", "<leader>kr", "<cmd>Neorg return<CR>", { desc = "Return" })
    vim.keymap.set("n", "<leader>kc", "<cmd>Neorg toc<CR>", { desc = "Create Table of Contents" })
    vim.keymap.set("n", "<leader>k<", "", { buffer = true, desc = "Demote" })
    vim.keymap.set("n", "<leader>k<,", "<Plug>(neorg.promo.demote)", { buffer = true, desc = "Demote" })
    vim.keymap.set(
      "n",
      "<leader>k<<",
      "<Plug>(neorg.promo.demote.nested)",
      { buffer = true, desc = "Demote recursively" }
    )
    vim.keymap.set(
      "n",
      "<leader>k<Space>",
      "<Plug>(neorg.qol.todo-items.todo.task-cycle)",
      { buffer = true, desc = "Switch the task between a select few states" }
    )
    vim.keymap.set("n", "<leader>k<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true, desc = "Open link" })
    vim.keymap.set(
      "n",
      "<leader>km",
      "<Plug>(neorg.looking-glass.magnify-code-block)",
      { buffer = true, desc = "Magnifies a code block to a separate buffer" }
    )
    vim.keymap.set(
      "n",
      "<leader>kd",
      "<Plug>(neorg.tempus.insert-date)",
      { buffer = true, desc = "Insert a link to a date" }
    )
    vim.keymap.set("n", "<leader>kl", "", { buffer = true, desc = "Lists" })
    vim.keymap.set(
      "n",
      "<leader>kli",
      "<Plug>(neorg.pivot.list.invert)",
      { buffer = true, desc = "Invert all items in a list" }
    )
    vim.keymap.set(
      "n",
      "<leader>klt",
      "<Plug>(neorg.pivot.list.toggle)",
      { buffer = true, desc = "Toggle a list from ordered <-> unordered" }
    )
    vim.keymap.set("n", "<leader>kt", "", { buffer = true, desc = "Todo tasks" })
    vim.keymap.set(
      "n",
      "<leader>kta",
      "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)",
      { buffer = true, desc = "Mark the task as 'ambiguous'" }
    )
    vim.keymap.set(
      "n",
      "<leader>ktc",
      "<Plug>(neorg.qol.todo-items.todo.task-cancelled)",
      { buffer = true, desc = "Mark the task as 'cancelled'" }
    )
    vim.keymap.set(
      "n",
      "<leader>ktd",
      "<Plug>(neorg.qol.todo-items.todo.task-done)",
      { buffer = true, desc = "Mark the task as 'done'" }
    )
    vim.keymap.set(
      "n",
      "<leader>kth",
      "<Plug>(neorg.qol.todo-items.todo.task-on-hold)",
      { buffer = true, desc = "Mark the task as 'on-hold'" }
    )
    vim.keymap.set(
      "n",
      "<leader>kti",
      "<Plug>(neorg.qol.todo-items.todo.task-important)",
      { buffer = true, desc = "Mark the task as 'important'" }
    )
    vim.keymap.set(
      "n",
      "<leader>ktp",
      "<Plug>(neorg.qol.todo-items.todo.task-pending)",
      { buffer = true, desc = "Mark the task as 'pending'" }
    )
    vim.keymap.set(
      "n",
      "<leader>ktr",
      "<Plug>(neorg.qol.todo-items.todo.task-recurring)",
      { buffer = true, desc = "Mark the task as 'recurring'" }
    )
    vim.keymap.set(
      "n",
      "<leader>ktu",
      "<Plug>(neorg.qol.todo-items.todo.task-undone)",
      { buffer = true, desc = "Mark the task as 'undone'" }
    )
    vim.keymap.set(
      "n",
      "<leader>k<M-CR>",
      "<Plug>(neorg.esupports.hop.hop-link.vsplit)",
      { buffer = true, desc = "Open link in a vertical split" }
    )
    vim.keymap.set(
      "n",
      "<leader>k<M-t>",
      "<Plug>(neorg.esupports.hop.hop-link.tab-drop)",
      { buffer = true, desc = "Open link in a new tab" }
    )
    vim.keymap.set("n", "<leader>k>.", "<Plug>(neorg.promo.promote)", { buffer = true, desc = "Promote" })
    vim.keymap.set(
      "n",
      "<leader>k>>",
      "<Plug>(neorg.promo.promote.nested)",
      { buffer = true, desc = "Promote recursively" }
    )
    vim.keymap.set("i", "<C-d>", "<Plug>(neorg.promo.demote)", { buffer = true, desc = "Demote recursively" })
    vim.keymap.set("i", "<C-t>", "<Plug>(neorg.promo.promote)", { buffer = true, desc = "Promote recursively" })
    vim.keymap.set(
      "i",
      "<M-CR>",
      "<Plug>(neorg.itero.next-iteration)",
      { buffer = true, desc = "Create an iteration of" }
    )
    vim.keymap.set(
      "i",
      "<M-d>",
      "<Plug>(neorg.tempus.insert-date.insert-mode)",
      { buffer = true, desc = "Insert a link to a date" }
    )
    vim.keymap.set("v", "<leader>k<", "<Plug>(neorg.promo.demote.range)", { buffer = true, desc = "Demote" })
    vim.keymap.set("v", "<leader>k>", "<Plug>(neorg.promo.promote.range)", { buffer = true, desc = "Promote" })
  end,
})

return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = true,
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.keybinds"] = {
        config = {
          default_keybinds = false,
        },
      },
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/notes",
          },
          index = "index.norg",
        },
      },
    },
  },
}
