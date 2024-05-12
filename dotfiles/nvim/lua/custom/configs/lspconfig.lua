local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "htmx",
  "bashls",
  "astro",
  "cssls",
  "clangd",
  "astro",
  "tsserver",
  "sqlls",
  "pylyzer",
  "pyright",
  "rust_analyzer",
  "mdx_analyzer",
  "markdown_oxide",
  "yamlls",
  "svelte",
  "prismals",
  "ltex",
  "dotls",
  "tailwindcss",
  "emmet_ls"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Without the loop, you would have to manually set up each LSP 
-- 
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

