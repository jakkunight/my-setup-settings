-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "astro",
  "arduino_language_server",
  "bashls",
  "tsserver",
  "biome",
  "cmake",
  "clangd",
  "csharp_ls",
  "css_variables",
  "cssmodules_ls",
  "dockerls",
  "emmet_ls",
  "htmx",
  "hyprls",
  "java_language_server",
  "kotlin_language_server",
  "ltex",
  "texlab",
  "markdown_oxide",
  "nixd",
  "nushell",
  "powershell_es",
  "pylyzer",
  "rust_ananlyzer",
  "sqlls",
  "svelte",
  "tailwindcss",
  "prismals",
  "yamlls",
  "zls",
}
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
