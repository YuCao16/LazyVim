return {
  "akinsho/bufferline.nvim",
  -- Modify the default configuration while preserving other LazyVim settings
  event = function()
    -- Don't load on dashboard
    if vim.bo.filetype == "snacks_dashboard" then
      return {}
    end
    return { "BufReadPost", "BufNewFile" }
  end,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "SnacksDashboardClosed",
      desc = "load bufferline after dashboard closes",
      callback = function()
        require("lazy").load({ plugins = { "bufferline.nvim" } })
      end,
    })
  end,
  keys = {
    { "<leader>bc", "<Cmd>BufferLinePick<CR>", desc = "Choose Buffer" },
    { "<leader>bC", "<Cmd>BufferLinePickClose<CR>", desc = "Choose Buffer to Close" },
  },
  opts = function(_, opts)
    opts.options.always_show_bufferline = true
    -- Ensure options table exists
    opts.options = opts.options or {}
    -- Ensure offsets table exists
    opts.options.offsets = opts.options.offsets or {}

    -- Filter out neo-tree from offsets while keeping other offset configurations
    -- This allows us to receive future LazyVim updates for other offsets
    opts.options.offsets = vim.tbl_filter(function(offset)
      return offset.filetype ~= "neo-tree"
    end, opts.options.offsets)

    local Offset = require("bufferline.offset")
    Offset.edgy = true
    Offset.get = function()
      return { left = "", left_size = 0, right = "", right_size = 0, total_size = 0 }
    end

    return opts
  end,
}
