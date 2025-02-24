return {
  "yetone/avante.nvim",
  cmd = { "AvanteAsk" },
  version = "*", -- set this if you want to always pull the latest change
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  opts = {
    provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-7-sonnet-20250219",
      temperature = 0,
      max_tokens = 4096,
    },
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "<leader>co",
        theirs = "<leader>ct",
        both = "<leader>cb",
        cursor = "<leader>cc",
        next = "]x",
        prev = "[x",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
    },
    hints = { enabled = true },
  },
  build = "make",
  keys = {
    {
      "<leader>a",
      "",
      desc = "+ai",
      mode = { "n", "v" },
    },
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      desc = "avante: ask",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "avante: refresh",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "avante: edit",
      mode = "v",
    },
  },
  dependencies = {
    "echasnovski/mini.icons", -- or nvim-tree/nvim-web-devicons
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below is optional, make sure to setup it properly if you have lazy=true
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
    },
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}
