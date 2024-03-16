local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = {
  -- Basic LSP Server:
  "html",
  "cssls",
  "clangd",
  "tsserver",
  "emmet_language_server",
  "emmet_ls",
  "marksman",
  "mdx_analyzer",
  "pyre",
  "bashls",
  "dotls",
  "sqlls",
  "yamlls",
  "prismals",
  "tailwindcss",
  "jsonls",

  -- Rarely use LSP servers:
  "rust_analyzer",
  "svelte",
  "powershell_es",
  "kotlin_language_server",
  "java_language_server",
  "htmx",
  "gradle_ls",
  "golangci_lint_ls",
  "csharp_ls",
  "cssmodules_ls",
  "cmake",
  "astro",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


