return {
  "folke/snacks.nvim",
  opts = {
    notifier = {
      timeout = 5000,
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
