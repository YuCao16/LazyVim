return {
  "yucao16/LspFinder.nvim",
  cmd = { "LspFinder" },
  keys = {
    {
      "gF",
      "<CMD>LspFinder<CR>",
      desc = "LspFinder",
      mode = { "n" },
    },
  },
  opts = {
    ui = {
      theme = "round",
      border = "rounded",
      preview = " ",
    },
  finder = {
    max_height = 0.3,
    position = "above",
    keys = {
      jump_to = "p",
      edit = { "o", "<CR>" },
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = { "q", "<ESC>" },
      close_in_preview = "q",
    },
  },
  request_timeout = 4000,
  },
}
