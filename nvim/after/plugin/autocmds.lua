local api = vim.api

-- Highlight on yank
api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
	false
)

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- formatting and linting
api.nvim_create_autocmd(
  "FileType",
  { 
    pattern = "python",
    command = [[nmap <buffer> <leader>es :Black<cr>]] 
  }
)

api.nvim_create_autocmd(
  "FileType",
  { 
    pattern = "html",
    command = [[nmap <buffer> <leader>es :normal gg=G<cr>]] 
  }
)

api.nvim_create_autocmd(
  "FileType",
  { 
    pattern = "json",
    command = [[nmap <buffer> <leader>es :%!jq .<cr>]] 
  }
)

api.nvim_create_autocmd(
  "FileType",
  { 
    pattern = "yaml",
    command = [[setlocal ts=2 sts=2 sw=2 expandtab]] 
  }
)

api.nvim_create_autocmd(
  "FileType",
  { 
    pattern = "javascript,typescript",
    command = [[nmap <leader>es :CocCommand eslint.executeAutofix <cr>]] 
  }
)

-- api.nvim_create_autocmd(
--   "User",
--   { 
--     command = [[CocJumpPlaceholder call CocActionAsync('showSignatureHelp') <cr>]] 
--   }
-- )


vim.cmd([[command! -nargs=0 Format :call CocActionAsync('format') ]])