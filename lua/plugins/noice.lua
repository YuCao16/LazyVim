return {
  "folke/noice.nvim",
  opts = {
    presets = {
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    lsp = {
      documentation = {
        opts = {
          border = {
            padding = { 0, 0 },
          },
        },
      },
    },
  },
}
