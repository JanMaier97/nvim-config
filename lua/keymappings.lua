-- clear search highlighting with enter
vim.keymap.set('n', '\\', function () vim.o.hlsearch = false end, {silent=true})

-- move between split windows using ctrl and a movement command only once
vim.keymap.set('n', '<c-j>', '<c-w><c-j>')
vim.keymap.set('n', '<c-k>', '<c-w><c-k>')
vim.keymap.set('n', '<c-l>', '<c-w><c-l>')
vim.keymap.set('n', '<c-h>', '<c-w><c-h>')

-- change window size using ctrl and the arrow keys
vim.keymap.set('n', '<c-up>', ' <c-w>-')
vim.keymap.set('n', '<c-down>', '<c-w>+')
vim.keymap.set('n', '<c-left>', '<c-w><')
vim.keymap.set('n', '<c-right>', '<c-w>>')

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- telescope keymaps
local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = 'Search Files'})
vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = 'Search by Grep'})
vim.keymap.set('n', '<leader>sb', telescope.buffers, { desc = 'Search existing buffers'})
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = 'Search help tags'})
vim.keymap.set('n', '<leader>sp', telescope.builtin, { desc = 'Search telescope pickers'})
vim.keymap.set('n', '<leader>/', telescope.current_buffer_fuzzy_find, { desc = 'Fuzzily search in current buffer'})

-- global lsp keymaps
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, {desc = 'Open diagnostics info in floating pane'}) -- show warnings/errors in popup
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, {desc = 'Open diagnostics in loclist'}) -- move diagnostics to loclist
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = 'Go to next diagnostic'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = 'Go to previous diagnostic'})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- telescope lsp mappings
        vim.keymap.set('n', 'gd', telescope.lsp_definitions, {desc = 'Go to Definition'})
        vim.keymap.set('n', 'gi', telescope.lsp_implementations, {desc = 'Go to Implementation'})
        vim.keymap.set('n', '<Leader>lr', telescope.lsp_references, {desc = 'List References'})
        vim.keymap.set('n', '<Leader>ld', telescope.lsp_document_symbols, {desc = 'List Document symbols'})
        vim.keymap.set('n', '<Leader>lw', telescope.lsp_workspace_symbols, {desc = 'List Workspace symbols'})
        vim.keymap.set('n', '<Leader>lW', telescope.lsp_dynamic_workspace_symbols, { desc = 'List dynamic Workspace symbols'})
        vim.keymap.set('n', '<Leader>lc', telescope.lsp_incoming_calls, {})
        vim.keymap.set('n', '<Leader>le', function() telescope.diagnostics { bufnr = 0 } end, { desc = 'List Errors in current buffers'})
        vim.keymap.set('n', '<Leader>lE', function() telescope.diagnostics { bufnr = nil } end, { desc = 'List Errors in all buffers'})

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
    end,
})
