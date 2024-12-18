local opt = vim.opt

-- encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,euc-jp,cp932"
opt.fileformats = "unix,dos,mac"

-- View
opt.number = true
opt.relativenumber = true

-- Tab & Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.wrap = true

-- 検索設定
opt.ignorecase = true
opt.smartcase = true
