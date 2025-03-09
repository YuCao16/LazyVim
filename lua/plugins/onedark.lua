return {
  {
    "yucao16/onedark.nvim",
    opts = {
      style = "darker",
      highlights = {
        -- Basic
        ColorColumn = { bg = "#323641" },
        EndOfBuffer = { bg = "none", fg = "#1f2329" }, -- ZenMode
        Search = { bg = "#99D1DB", fg = "#282c34", ctermfg = 0, ctermbg = 11 },
        IncSearch = { bg = "#99D1DB", fg = "#282c34", ctermfg = 0, ctermbg = 11 },
        CurSearch = { bg = "#99D1DB", fg = "#282c34", ctermfg = 0, ctermbg = 11 },
        WinBar = { fg = "#9095a2", bg = "none" }, -- Navic
        WinBarNC = { bg = "none" }, -- Navic
        Conceal = { fg = "#abb2bf", bg = "#282C34" },
        VertSplit = { cterm = "bold", gui = "bold", fg = "#50585b" },
        WinSeparator = { link = "VertSplit" },
        MatchParen = { bg = "#727169", fg = "#ff966c", fmt = "bold" },
        MatchWord = { bg = "none", fg = "#ff966c", fmt = "bold" },

        -- For native lsp configs
        LspInfoBorder = { fg = "#99a3b3" },
        Identifier = { fg = "#abb2bf" },
        ["@operator"] = { link = "Operator" },
        ["@parameter"] = { fg = "#d19a66" },
        -- ["@variable.builtin"] = { link = "Operator" },
        ["@variable.parameter"] = { link = "@parameter" },
        -- ["@type.builtin"] = { link = "@function.builtin" },

        -- Sianature
        LspSignatureActiveParameter = { link = "Search" },

        -- DropBar
        DropBarIconKindFolder = { fg = "#8094b4" },

        -- Neo-Tree
        NeoTreeDirectoryIcon = { fg = "#8094b4" },
        NeoTreeIndentMarker = { fg = "#abb2bf" },
        NeoTreeExpander = { fg = "#abb2bf" },
        NeoTreeWinSeparator = { link = "VertSplit" },
        -- NeoTreeNormal = { bg = "#1f2329", fg = "#a0a8b7" },
        -- NeoTreeEndOfBuffer = { bg = "#1f2329" },

        -- Lspsaga
        FinderPreviewSearch = { bg = "#e95678", fg = "#1f2329" },
        SagaBorder = { bg = "none", fg = "#c8c093" },

        -- Float and Markdown.nvim
        -- Lighter --
        -- FloatBorder = { bg = "#282c34", fg = "#c8c093" },
        -- NormalFloat = { bg = "#282c34"},
        -- RenderMarkdownCode = {bg = "#282c34"},
        -- Darker --
        FloatBorder = { bg = "#1B1F23", fg = "#c8c093" },
        NormalFloat = { bg = "#1B1F23" },
        RenderMarkdownCode = { bg = "#1B1F23" },
        -- Same as Background --
        -- FloatBorder = { bg = "none", fg = "#c8c093" },
        -- RenderMarkdownCode = { bg = "#1f2329" },
        -- NormalFloat = { bg = "none", fg = "none" },

        -- Indent Blinkline
        IblIndent = { fg = "#535965", fmt = "none" },
        SnacksIndentScope = { fg = "#535965", fmt = "none" },

        -- Rainbow Delimieter
        rainbowcol1 = { fg = "#ffd700" },
        RainbowDelimiterRed = { fg = "#ffd700" },
        RainbowDelimiterYellow = { fg = "#e2b86b" },
        RainbowDelimiterBlue = { fg = "#4fa6ed" },
        RainbowDelimiterOrange = { fg = "#cc9057" },
        RainbowDelimiterGreen = { fg = "#e55561" },
        RainbowDelimiterViolet = { fg = "#50E0AC" },
        RainbowDelimiterCyan = { fg = "#bf68d9" },

        -- Lualine
        lualine_c_normal = { fg = "#abb2bf" },
      },
    },
  },
}
