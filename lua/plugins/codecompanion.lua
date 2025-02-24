return {
  "olimorris/codecompanion.nvim",
  config = true,
  lazy = true,
  cmd = { "CodeCompanion", "CodeCompanionChat" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
