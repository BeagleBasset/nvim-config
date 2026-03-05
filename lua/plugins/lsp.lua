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

vim.diagnostic.config({
    signs = true,              -- gutter-ben kis ikonok
    underline = true,          -- aláhúzás hibás részeknél
    update_in_insert = false,  -- ne frissítsen gépelés közben

    virtual_text = {
        prefix = "",      -- vagy "", "✗", bármi
        spacing = 2,       -- szóköz a kód és üzenet között
    },
})
