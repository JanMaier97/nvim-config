-- configure onedark colorscheme
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- Set lualine as statusline
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
    },
}


require('telescope').setup{
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
require('telescope').load_extension('fzy_native')

require('lspconfig').rust_analyzer.setup{
    -- cmd = { "C:/Tools/rust-analyzer-2023-09-18/rust-analyzer.exe" }
}

require('nvim-treesitter.configs').setup {
    ensure_installed = {"lua", "vimdoc", "rust", "c_sharp"},
}
