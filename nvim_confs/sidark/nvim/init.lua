-- load all plugins
require("pluginsList.lua")
require("file-icons.lua")

require("misc-utils.lua")
require("nvimTree.lua")
require("bufferline.lua")
require("statusline.lua")
require("telescope.lua")

require("gitsigns.lua")
require "colorizer".setup()

-- lsp
require("lspconfig.lua")
require("compe.lua")

local cmd = vim.cmd
local g = vim.g

g.mapleader = " "
g.auto_save = 1

-- colorscheme related stuff

cmd "syntax enable"
cmd "syntax on"

local base16 = require "base16"
base16(base16.themes["onedark"], true)

-- blankline

local indent = 2

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

cmd("hi IndentBlanklineChar guifg=#2a2e36")

g.indent_blankline_filetype_exclude = {"help", "terminal"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

require("treesitter.lua")
require("mappings.lua")

-- highlights --
cmd("hi  LineNr guifg=#363a42 guibg=NONE")
cmd("hi Comment guifg=#363a42")

cmd("hi SignColumn guibg=NONE")
cmd("hi VertSplit guibg=NONE guifg=#2a2e36")
cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
cmd("hi DiffChange guifg =#3A3E44 guibg = none")
cmd("hi DiffModified guifg = #81A1C1 guibg = none")
cmd("hi EndOfBuffer guifg=#1e222a")

-- telescope stuff and popupmenu
cmd("hi TelescopeBorder   guifg=#2a2e36")
cmd("hi TelescopePromptBorder   guifg=#2a2e36")
cmd("hi TelescopeResultsBorder  guifg=#2a2e36")
cmd("hi TelescopePreviewBorder  guifg=#525865")
cmd("hi PmenuSel  guibg=#98c379")

-- tree folder name , icon color
cmd("hi NvimTreeFolderIcon guifg = #61afef")
cmd("hi NvimTreeFolderName guifg = #61afef")
cmd("hi NvimTreeIndentMarker guifg=#545862")

cmd("hi Normal guibg=NONE ctermbg=NONE")

require("nvim-autopairs").setup()
require("lspkind").init(
    {
        File = " "
    }
)

-- nvimTree bg color

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber
]], false)

-- inactive statuslines as thin splitlines
cmd("highlight! StatusLineNC gui=underline guibg=NONE guifg=#2a2e36")
