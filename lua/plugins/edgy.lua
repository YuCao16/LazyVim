return {
  {
    "folke/edgy.nvim",
    opts = {
      exit_when_last = true,
      animate = { enabled = false },
      options = {
        left = { size = 30 },
        bottom = { size = 10 },
        right = { size = 40 },
        top = { size = 10 },
      },
      wo = {
        -- Setting to `true`, will add an edgy winbar.
        -- Setting to `false`, won't set any winbar.
        -- Setting to a string, will set the winbar to that string.
        winbar = true,
        winfixwidth = true,
        winfixheight = false,
        winhighlight = "",
        -- winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
        spell = false,
        signcolumn = "no",
      },
    },
  },
}
