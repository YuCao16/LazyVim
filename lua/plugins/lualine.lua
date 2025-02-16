local conditionals = {
  has_enough_room = function()
    return vim.o.columns > 100
  end,
  has_comp_before = function()
    return vim.bo.filetype ~= ""
  end,
  has_git = function()
    local gitdir = vim.fs.find(".git", {
      limit = 1,
      upward = true,
      type = "directory",
      path = vim.fn.expand("%:p:h"),
    })
    return #gitdir > 0
  end,
}

---@class lualine_hlgrp
---@field fg string
---@field bg string
---@field gui string?
local utils = {
  force_centering = function()
    return "%="
  end,
}
local components = {
  lsp = {
    function()
      local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
      local clients = vim.lsp.get_clients()
      local lsp_lists = {}
      local available_servers = {}
      if next(clients) == nil then
        return "󱚧 " -- No server available
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        local client_name = client.name
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          -- Avoid adding servers that already exists.
          if not lsp_lists[client_name] then
            lsp_lists[client_name] = true
            table.insert(available_servers, client_name)
          end
        end
      end
      return next(available_servers) == nil and "󱚧 "
        or string.format("%s[%s]", "󱜙 ", table.concat(available_servers, ", "))
    end,
    color = { fg = "#61AFEF", gui = "bold" },
    cond = conditionals.has_enough_room,
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
    cond = conditionals.has_enough_room,
  },
  tabwidth = {
    function()
      return " " .. vim.api.nvim_get_option_value("shiftwidth", { scope = "local" })
    end,
    padding = 1,
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
