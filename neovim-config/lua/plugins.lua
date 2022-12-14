local packer = require('packer')
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use('wbthomason/packer.nvim')
    -- 你的插件列表...
    -- Packer 可以升级自己
    use('wbthomason/packer.nvim')
    --------------------- colorschemes --------------------
    -- tokyonight
    use('folke/tokyonight.nvim')
    -------------------------------------------------------
    use({ 'ellisonleao/gruvbox.nvim' })
    -- nvim-tree (新增)
    use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })
    -- bufferline (新增)
    use({ 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons', 'moll/vim-bbye' } })
    -- lualine (新增)
    use({ 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } })
    use('arkav/lualine-lsp-progress')
    -- telescope （新增）
    use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })
    -- telescope extensions
    use('LinArcX/telescope-env.nvim')
    use('tribela/vim-transparent')
    -- indent-blankline
    use('lukas-reineke/indent-blankline.nvim')
    -- dashboard-nvim (新增)
    use('glepnir/dashboard-nvim')
    -- project
    use('ahmedkhalf/project.nvim')
    -- treesitter （新增）
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    -- 代码格式化 (新增)
    use('mhartington/formatter.nvim')
    --------------------- LSP --------------------
    use('williamboman/nvim-lsp-installer')
    -- Lspconfig
    use({ 'neovim/nvim-lspconfig' })
    -- 补全引擎
    use('hrsh7th/nvim-cmp')
    -- snippet 引擎
    use('hrsh7th/vim-vsnip')
    -- 补全源
    use('hrsh7th/cmp-vsnip')
    use('hrsh7th/cmp-nvim-lsp') -- { name = nvim_lsp }
    use('hrsh7th/cmp-buffer') -- { name = 'buffer' },
    use('hrsh7th/cmp-path') -- { name = 'path' }
    use('hrsh7th/cmp-cmdline') -- { name = 'cmdline' }
    -- 常见编程语言代码段
    use('rafamadriz/friendly-snippets')
    -- ui (新增)
    use('onsails/lspkind-nvim')
    use('tami5/lspsaga.nvim') -- 新增
    use('junegunn/fzf.vim') -- 新增
    --    use('iamcco/markdown-preview.nvim')
    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
})

-- 每次保存 plugins.lua 自动安装插件
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
