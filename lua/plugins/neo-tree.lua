return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = false, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        opts = {
          -- hint = "floating-big-letter",
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            bo = {
              filetype = {
                "neo-tree-popup",
                "quickfix",
                "VistaNvim",
                "notify",
                "fidget",
                "Avante",
                "AvanteInput",
                "AvanteSelectedFiles",
                "neo-tree",
                "edgy",
                "snacks_notif",
                "snacks_terminal",
              },
              buftype = { "terminal", "quickfix" },
            },
          },
        },
      },
    },
    opts = {
      close_if_last_window = true,
      enable_diagnostics = false,
      popup_border_style = "rounded",
      update_cwd = true,
      enable_git_status = true,
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 2,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        buffers = {
          follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
            },
          },
        },
        icon = {
          folder_closed = "󰉋",
          folder_open = "󰝰",
          folder_empty = "",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
      },
      window = {
        position = "left",
        width = 28,
        mappings = {
          ["<2-LeftMouse>"] = "open_with_window_picker",
          ["<cr>"] = "open_with_window_picker",
          ["o"] = "open_with_window_picker",
          ["l"] = "open_with_window_picker",
        },
      },
      sources = {
        "filesystem",
        -- "document_symbols",
        -- "git_status",
      },
    },
  },
}
