return {
  "petertriho/nvim-scrollbar",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    excluded_filetypes = {
      "dropbar_menu",
      "dropbar_menu_fzf",
      "DressingInput",
      "cmp_docs",
      "cmp_menu",
      "noice",
      "prompt",
      "TelescopePrompt",
      "AvanteInput",
      "Avante",
      "AvanteSelectedFiles",
      "vista",
    },
  },
}
