return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local ensure_installed = {
        -- DAP (Debuggers)
        "debugpy",
        -- Formatters & Linters (Non-LSP)
        "stylua",
        "shfmt",
        "markdown-toc",
        "markdownlint-cli2",
        "marksman", -- Note: marksman is an LSP, but keeping it here is fine if not configured in lspconfig below
      }

      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, ensure_installed)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        underline = true,
        float = {
          focusable = false,
          border = "rounded",
          source = "always",
          header = "🙀Diagnostics:",
          prefix = "",
        },
      },
      hover = {
        border = "rounded",
        focusable = false,
      },
      servers = {
        pyright = { enabled = false },
        basedpyright = { enabled = false },
        jedi_language_server = { enabled = false },
        ruff = {
          init_options = {
            settings = {
              configuration = vim.fn.stdpath("config") .. "/lua/plugins/ruff.toml",
            },
          },
        },
        ty = {},
      },
      setup = {
        sourcery = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "sourcery" then
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
}
