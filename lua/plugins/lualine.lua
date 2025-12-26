local utils = {
  force_centering = function()
    return "%="
  end,
  has_enough_room = function()
    return vim.o.columns > 100
  end,
}

local components = {
  lsp = {
    function()
      local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
      local clients = vim.lsp.get_clients({ bufnr = 0 })

      if #clients == 0 then
        return "󱚧  No LSP"
      end

      local active_servers = {}
      for _, client in ipairs(clients) do
        -- Only show clients that are attached to this buffer
        table.insert(active_servers, client.name)
      end

      -- Remove duplicates if any
      local seen = {}
      local unique_servers = {}
      for _, v in ipairs(active_servers) do
        if not seen[v] then
          seen[v] = true
          table.insert(unique_servers, v)
        end
      end

      return #unique_servers == 0 and "󱚧  No LSP"
        or string.format("%s[%s]", "󱜙 ", table.concat(unique_servers, ", "))
    end,
    color = { fg = "#61AFEF", gui = "bold" },
    cond = utils.has_enough_room,
  },
  python_venv = {
    function()
      if vim.bo.filetype ~= "python" then
        return ""
      end
      local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
      if venv then
        return "󰢩 " .. vim.fn.fnamemodify(venv, ":t")
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

    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      component_separators = "",
      section_separators = { left = "", right = "" },
      globalstatus = true,
    })

    opts.sections.lualine_a = {
      { "mode", separator = { left = "" }, right_padding = 2 },
    }

    opts.sections.lualine_b = {
      { "branch" },
      { "diagnostics" },
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
