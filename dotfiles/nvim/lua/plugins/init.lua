return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "rust-analyzer",
        "pylyzer",
        "biome",
        "markdown-oxide",
        "astro-language-server",
        "svelte-language-server",
        "oxlint",
        "clangd",
        "bash-language-server",
        "mdx-analyzer",
        "cmake-language-server",
        "json-lsp",
        "jsonlint",
        "prisma-language-server",
        "tailwindcss-language-server",
        "powershell-editor-services",
        "sqlls",
        "texlab",
        "yaml-language-server"
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "astro",
        "tsx",
        "arduino",
        "bash",
        "powershell",
        "c",
        "cmake",
        "cpp",
        "csv",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "hyprlang",
        "ini",
        "jq",
        "jsdoc",
        "java",
        "json",
        "kotlin",
        "latex",
        "llvm",
        "markdown",
        "markdown_inline",
        "nix",
        "passwd",
        "pem",
        "perl",
        "php",
        "prisma",
        "python",
        "rasi",
        "readline",
        "query",
        "comments",
        "rust",
        "regex",
        "smali",
        "tmux",
        "todotxt",
        "yaml",
        "zig",
        "xml",
        "c_sharp"
      },
    },
  },
}
