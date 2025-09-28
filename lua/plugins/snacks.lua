return {
  "folke/snacks.nvim",
  dependencies = {
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      opts = {
        hint = "statusline-winbar",
        chars = "FJDKSLA;CMRUEIWOQP", -- F for left, J for right
        show_prompt = false, -- Don't show prompt message
        filter_rules = {
          autoselect_one = true,
          include_current_win = false,
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
              "snacks_picker",
              "snacks_picker_list",
              "snacks_picker_preview",
              "snacks_picker_input",
              -- "snacks_dashboard",
              "snacks_layout_box",
            },
            buftype = { "terminal", "quickfix" },
          },
        },
      },
    },
  },
  opts = {
    notifier = {
      timeout = 5000,
    },
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    picker = {
      sources = {
        explorer = {
          -- Enable tree view with git and diagnostics
          tree = true,
          git_status = true,
          git_untracked = true,
          diagnostics = true,
          follow_file = true,
          watch = true,
          focus = "list",
          -- Layout configuration similar to neo-tree
          layout = {
            preset = "sidebar",
            preview = false,
            layout = {
              position = "left",
              width = 35,
              border = "none",
            },
          },
          -- Sorting and matching
          sort = { fields = { "sort" } },
          matcher = {
            sort_empty = false,
            fuzzy = false,
          },
          -- Formatters
          formatters = {
            file = {
              filename_only = true,
            },
            severity = { pos = "right" },
          },
          -- Icons similar to neo-tree
          icons = {
            files = {
              dir = "󰉋 ",
              dir_open = "󰝰 ",
              file = " ",
            },
            tree = {
              vertical = "│ ",
              middle = "│ ",
              last = "└╴",
            },
          },
          -- Custom actions for window picker integration and fixes
          actions = {
            open_with_window_picker = function(picker, item)
              -- If it's a directory, just use default confirm action (expand/collapse)
              if item.dir then
                return picker:action("confirm", item)
              end

              -- For files, use window picker
              local ok, window_picker = pcall(require, "window-picker")
              if ok then
                local win = window_picker.pick_window()
                if not win then
                  -- User pressed ESC, cancel the operation
                  return
                end
                if win ~= vim.api.nvim_get_current_win() then
                  vim.api.nvim_set_current_win(win)
                end
              end
              -- Perform the default confirm action
              return picker:action("confirm", item)
            end,

          },

          -- Key mappings to match neo-tree behavior
          win = {
            list = {
              keys = {
                -- Navigation similar to neo-tree with window picker
                ["<2-LeftMouse>"] = "open_with_window_picker",
                ["<cr>"] = "open_with_window_picker",
                ["o"] = "open_with_window_picker",
                ["l"] = "open_with_window_picker",
                ["h"] = "explorer_close",
                ["<bs>"] = "explorer_up",
                ["."] = "explorer_focus",

                -- File operations
                ["a"] = "explorer_add",
                ["d"] = "explorer_del",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["m"] = "explorer_move",
                ["y"] = "explorer_yank",
                ["p"] = "explorer_paste",

                -- View toggles
                ["P"] = "toggle_preview",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",

                -- Git navigation
                ["]g"] = "explorer_git_next",
                ["[g"] = "explorer_git_prev",

                -- Diagnostics navigation
                ["]d"] = "explorer_diag_next",
                ["[d"] = "explorer_diag_prev",

                -- Utility
                ["u"] = "explorer_update",
                ["<c-c>"] = "tcd",
              },
            },
          },
        },
      },
    },
    indent = {
      scope = {
        enabled = true,
        char = "┃",
      },
    },
    dashboard = {
      sections = {
        { section = "header" },
        {
          pane = 2,
          section = "terminal",
          cmd = [[
            echo -e "\033[1;35m  _________________________________
< Hi $(whoami)! Happy Coding! 
  ---------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\

                ||----w |
                ||     ||\033[0m"
          ]],
          height = 7,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
  },
}
