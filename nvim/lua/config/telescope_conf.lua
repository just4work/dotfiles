-- require"telescope.builtin".find_files(require"telescope.themes".get_ivy({layout_config={preview_width=0.8}}))

require("telescope").setup{
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> "
  },
  pickers = {
    find_files = {
      theme = "ivy"
    },
    live_grep = {
      theme = "ivy"
    },
    buffers = {
      theme = "ivy"
    },
    current_buffer_tags = {
      theme = "ivy"
    }
  }
}

local open_dir = function(config)
    local opt = require('telescope.themes').get_ivy {
        cwd = config.dir,
        prompt_title = config.title,
        shorten_path = true
    }
    require('telescope.builtin').find_files(opt)
end


local builtin = require('telescope.builtin')
local ivy_theme = require('telescope.themes').get_ivy()
local mappings = {
  tags = function() 
    require('telescope.builtin').current_buffer_tags(ivy_theme)
  end
}

return mappings
-- require('telescope').load_extension('fzf')
-- require('telescope').load_extension('coc')

