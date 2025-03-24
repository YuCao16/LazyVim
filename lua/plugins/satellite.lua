return {
  "lewis6991/satellite.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    excluded_filetypes = {"AvanteInput", "Avante", "AvanteSelectedFiles"},
  },
}
