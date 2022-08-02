local g = vim.g
local keymap = vim.keymap.set
local nkeymap = vim.api.nvim_set_keymap

-- source: https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
-- Commands                        Mode
-- --------                        ----
-- nmap, nnoremap, nunmap          Normal mode
-- imap, inoremap, iunmap          Insert and Replace mode
-- vmap, vnoremap, vunmap          Visual and Select mode
-- xmap, xnoremap, xunmap          Visual mode
-- smap, snoremap, sunmap          Select mode
-- cmap, cnoremap, cunmap          Command-line mode
-- omap, onoremap, ounmap          Operator pending mode

-- Space as leader key
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

-- Word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

nkeymap("n", "<F6>", ":NvimTreeToggle <CR>", { silent = true })


-- jk to ESC
keymap("i", "jk", "<ESC>", { noremap = true, silent = true })


--
-- va}a} visual select block recur
-- yiB yank inner block
nkeymap("i", "<F5>", "<C-R>=expand('%:p:h')<CR>", { noremap = true, silent = false })

-- coc.nvim
-- inspired by albingroen/quick.nvim
nkeymap("n", "<leader>cl", "<Plug>(coc-codelens-action)", {})
nkeymap("n", "<leader>a", "<Plug>(coc-codeaction)", {})
nkeymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
nkeymap("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
nkeymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
nkeymap("n", "[g", "<Plug>(coc-diagnostic-prev)", {})
nkeymap("n", "]g", "<Plug>(coc-diagnostic-next)", {})
nkeymap("n", "<leader>f", ":CocCommand prettier.formatFile<CR>", {noremap = true})
nkeymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
nkeymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
nkeymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
nkeymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

nkeymap("n", ";h", ":WhichKey \\<leader> <CR>", { noremap = true})


-- telescope
keymap("n", "<C-P>", "<cmd> lua require(\"telescope.builtin\").find_files({cwd = \"%:h\"}) <CR>", {silent = true, noremap = true})
nkeymap("n", "<leader>b", "<cmd> Telescope buffers <CR>", {silent = true, noremap = false})
nkeymap("n", "<leader>\\", "<cmd> Telescope live_grep <CR>", {silent = true, noremap = true})
nkeymap("n", "<leader>t", "<cmd> Telescope current_buffer_tags <CR>", {silent = true, noremap = true})


