# 新增markdown插件的方法

在plugins.lua中，新增如下插件
use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})


2.下载：packersync
3.安装：PackerInstall
4.重启即可使用
