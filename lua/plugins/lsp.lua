return {
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
              -- typeCheckingMode = "off",
              -- typeCheckingMode = "strict",
              diagnosticMode = "openFilesOnly",
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
              },
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
}
