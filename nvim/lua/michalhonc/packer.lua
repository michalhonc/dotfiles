vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Define your plugins using Packer.nvim's use() function
    use('dense-analysis/ale')
    use('chentoast/marks.nvim')

    use('jparise/vim-graphql')
    use('jason0x43/vim-js-indent')
    use('Quramy/vim-js-pretty-template')
    use('andrewradev/splitjoin.vim')
    -- use('mxw/vim-jsx')  -- Commented out example
    use('pantharshit00/vim-prisma')
    -- use('sheerun/vim-polyglot')  -- Commented out example
    use('tomlion/vim-solidity')
    use('evanleck/vim-svelte', {
        branch = 'main'
    })
    use('stefandtw/quickfix-reflector.vim')
    use('jremmen/vim-ripgrep')
    use('junegunn/fzf', {
        dir = '~/.fzf',
        run = './install --all'
    })
    use('junegunn/fzf.vim')
    use('mbbill/undotree')
    use('ibhagwan/fzf-lua')
    use('editorconfig/editorconfig-vim')
    use('easymotion/vim-easymotion')
    use('itchyny/lightline.vim')
    use('tpope/vim-surround')
    use('nvim-tree/nvim-tree.lua')
    use('tpope/vim-commentary')
    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
    })
    use('cormacrelf/vim-colors-github')
    use('tpope/vim-fugitive')
    use('JoosepAlviste/nvim-ts-context-commentstring')
    use { "johmsalas/text-case.nvim",
      config = function()
        require('textcase').setup {}
      end
    }
end)
