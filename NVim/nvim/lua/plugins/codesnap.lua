return {
  "mistricky/codesnap.nvim",
  build = "make",
  keys = {
    { "<leader>cp", "<cmd>CodeSnap<cr>", mode = "s", desc = "Save selected code snapshot into clipboard" },
    { "<leader>cP", "<cmd>CodeSnapSave<cr>", mode = "s", desc = "Save selected code snapshot in ~/Pictures" },
  },
  opts = {
    mac_window_bar = true, --<-
    title = "CodeSnap.nvim", --<-
    code_font_family = "FiraCode Nerd Font",
    watermark_font_family = "Victor Mono Nerd Font",
    watermark = "#bercianor",
    bg_color = "#fc5",
    has_breadcrumbs = true,
    show_workspace = false,
    breadcrumbs_separator = "👉",
    has_line_number = true,
    min_width = 0,
    bg_x_padding = 122,
    bg_y_padding = 82,
    save_path = "~/Documents", -- os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME") .. "/Documents"),
  },
}
