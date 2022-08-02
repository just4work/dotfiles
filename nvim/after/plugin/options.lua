local opt = vim.opt
local g = vim.g

opt.hlsearch = true
opt.incsearch = true
opt.showmatch = true
opt.number = true
opt.relativenumber = true
opt.hidden = true
-- opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 300
opt.signcolumn = "yes"

opt.scrolloff = 2
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 2
opt.softtabstop = 0
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true

opt.tagfunc = "CocTagFunc"
opt.fileformat = "unix"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- g.netrw_list_hide = '.*\node_modules$'
-- g.netrw_banner = 0
-- g.netrw_winsize = 10
-- g.netrw_liststyle = 3
-- g.netrw_altv = 1
-- g.netrw_browse_split = 4