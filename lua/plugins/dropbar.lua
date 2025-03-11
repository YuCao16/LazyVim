return {
  {
    "Bekaboo/dropbar.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<Leader>;", function() require("dropbar.api").pick() end, desc = "Dropbar: Pick symbols" },
      { "[;", function() require("dropbar.api").goto_context_start() end, desc = "Dropbar: Go to context start" },
      { "];", function() require("dropbar.api").select_next_context() end, desc = "Dropbar: Select next context" },
    },
  },
}
