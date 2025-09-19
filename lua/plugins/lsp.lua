return {
  {
    "mason-org/mason.nvim",

    opts = function(_, opts)
      local ensure_installed = {
        -- python
        "ruff",
        "pyright",
        "basedpyright",
        "jedi-language-server",
        "debugpy",
        -- lua
        "lua-language-server",
        "stylua",
        -- shell
        "bash-language-server",
        "shfmt",
        -- markdown
        "markdown-toc",
        "markdownlint-cli2",
        "marksman",
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
        pyright = {
          settings = {
            python = {
              analysis = {
                -- typeCheckingMode = "strict",
                diagnosticMode = "openFilesOnly",
                argAssignmentFunction = false,
              },
              pythonPath = "python3",
            },
          },
        },
        ruff = {
          init_options = {
            settings = {
              configuration = vim.fn.stdpath("config") .. "/lua/plugins/ruff.toml",
            },
          },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              -- disableLanguageServices = true,
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
        },
      },
      setup = {
        pyright = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "pyright" then
              -- disable hover in favor of jedi-language-server
              client.server_capabilities.hoverProvider = false
              client.server_capabilities.signatureHelpProvider = nil
            end
          end)
        end,
        basedpyright = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "basedpyright" then
              client.server_capabilities.semanticTokensProvider = nil
              client.server_capabilities.hoverProvider = false
              client.server_capabilities.signatureHelpProvider = nil
            end
          end)
        end,
        jedi_language_server = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "jedi_language_server" then
              client.server_capabilities.codeActionProvider = false
              client.server_capabilities.completionProvider = nil
              client.server_capabilities.referencesProvider = false
              client.server_capabilities.definitionProvider = false
              client.server_capabilities.documentHighlightProvider = false
            end
          end)
        end,
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
