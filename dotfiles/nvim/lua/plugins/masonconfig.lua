-- I need to setup my Mason config here.
return {
  {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "html-lsp",
        "css-lsp",
        "rust-analyzer",
      },
    },
  },
}
