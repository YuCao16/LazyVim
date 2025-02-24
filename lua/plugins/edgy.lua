return {
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.exit_when_last = true
      opts.animate = { enabled = false }
      opts.options = {
        left = { size = 30 },
        bottom = { size = 10 },
        right = { size = 40 },
        top = { size = 10 },
      }
      opts.wo = {
        -- Setting to `true`, will add an edgy winbar.
        -- Setting to `false`, won't set any winbar.
        -- Setting to a string, will set the winbar to that string.
        winbar = false,
        winfixwidth = true,
        winfixheight = false,
        winhighlight = "",
        -- winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
        spell = false,
        signcolumn = "no",
      }

      if opts.left then
        opts.left = vim.tbl_filter(function(win)
          return not (win.ft == "neo-tree" and win.title and win.title:match("Neo%-Tree"))
        end, opts.left)

        table.insert(opts.left, 1, {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = function()
            vim.cmd("Neotree show position=left filesystem")
          end,
        })
      end

      return opts
    end,
  },
}
