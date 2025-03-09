local utils = {
  force_centering = function()
    return "%="
  end,
  has_enough_room = function()
    -- Small screens (<= 80): show minimal info
    -- Medium screens (81-120): show moderate info
    -- Large screens (>120): show all info
    local min_width = 80
    local preferred_width = 120

    if vim.o.columns <= min_width then
      return false
    elseif vim.o.columns <= preferred_width then
      -- For medium screens, check if we're in a special mode that needs more space
      return not (vim.bo.filetype == "neo-tree" or vim.bo.filetype == "help")
    else
      return true
    end
  end,
}

local components = {
  lsp = {
    function()
      local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
      local clients = vim.lsp.get_clients()

      if #clients == 0 then
        return "󱚧  No LSP"
      end

      local active_servers = {}
      for _, client in ipairs(clients) do
        if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
          table.insert(active_servers, client.name)
        end
      end

      return #active_servers == 0 and "󱚧  No LSP"
        or string.format("%s[%s]", "󱜙 ", table.concat(active_servers, ", "))
    end,
    color = { fg = "#61AFEF", gui = "bold" },
    cond = utils.has_enough_room,
  },
  python_venv = {
    function()
      local function env_cleanup(venv)
        if string.find(venv, "/") then
          local final_venv = venv
          for w in venv:gmatch("([^/]+)") do
            final_venv = w
          end
          venv = final_venv
        end
        return venv
      end

      if vim.api.nvim_get_option_value("filetype", { scope = "local" }) == "python" then
        local venv = os.getenv("CONDA_DEFAULT_ENV")
        if venv then
          return "󰢩 " .. env_cleanup(venv)
        end
        venv = os.getenv("VIRTUAL_ENV")
        if venv then
          return "󰢩 " .. env_cleanup(venv)
        end
      end
      return ""
    end,
    color = { fg = "#AFD700", gui = "bold" },
    cond = utils.has_enough_room,
  },
}

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local icons = LazyVim.config.icons
    -- Preserve existing options or set defaults
    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      component_separators = "",
      section_separators = { left = "", right = "" },
      globalstatus = true,
    })
    -- Update mode component settings while preserving the structure
    opts.sections.lualine_a = {
      { "mode", separator = { left = "" }, right_padding = 2 },
    }
    opts.sections.lualine_b = {
      { "branch" },
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
    }
    opts.sections.lualine_c = {
      { utils.force_centering },
      components.lsp,
    }
    opts.sections.lualine_y = {
      components.python_venv,
      "filetype",
      "filesize",
      "progress",
    }
    opts.sections.lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    }
    return opts
  end,
}
