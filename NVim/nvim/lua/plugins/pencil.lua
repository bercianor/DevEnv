return {
  {
    "preservim/vim-pencil",
    ft = { "markdown", "md", "text" }, -- carga al abrir estos tipos
    init = function()
      -- variables globales antes de cargar el plugin
      vim.g["pencil#wrapModeDefault"] = "soft" -- 'soft' o 'hard'
      vim.g["pencil#autoformat"] = 1 -- 1 = enable
      vim.g["pencil#textwidth"] = 74
      vim.g["pencil#map#suspend_af"] = "K" -- K + o suspende autoformat
      vim.g["pencil#conceallevel"] = 3
      vim.g["pencil#concealcursor"] = "c"
    end,
    config = function()
      -- auto-inicializar por FileType (seguro si plugin cargó con 'ft')
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "md", "text" },
        callback = function()
          vim.fn["pencil#init"]()
        end,
      })
    end,
  },
}
