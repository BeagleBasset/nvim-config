-- 1. Capabilities lekérése (marad a cmp-nvim-lsp-nél, ha azt használod)
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 2. AZ ÚJ MÓDSZER: vim.lsp.config használata (nvim 0.11+)
-- Itt már nincs szükség a require('lspconfig').setup-ra

-- C++ LSP (clangd)
vim.lsp.config('clangd', {
    capabilities = capabilities,
})
vim.lsp.enable('clangd')

-- Python LSP (pyright)
vim.lsp.config('pyright', {
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
    -- A root_dir meghatározása is változott kicsit:
    root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
})
vim.lsp.enable('pyright')

-- 4. Go LSP (gopls)
vim.lsp.config('gopls', {
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                nilness = true,
            },
            staticcheck = true,
        },
    },
    root_dir = vim.fs.root(0, { "go.mod", ".git" }),
})
vim.lsp.enable('gopls')

vim.diagnostic.config({
    signs = true,              -- gutter-ben kis ikonok
    underline = true,          -- aláhúzás hibás részeknél
    update_in_insert = false,  -- ne frissítsen gépelés közben

    virtual_text = {
        prefix = "",      -- vagy "", "✗", bármi
        spacing = 2,       -- szóköz a kód és üzenet között
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local ok, signature = pcall(require, "lsp_signature")
    if ok then
      signature.on_attach({
        hint_enable = false,
        floating_window = true,
        handler_opts = { border = "rounded" },
      }, args.buf)
    end
  end,
})
