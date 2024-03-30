local popup = require("plenary.popup")

local Win_id

-- What happens wehen selecting something in menu
-- local cb = function(_, sel)
--   vim.cmd("cd " .. sel)
-- end

function CloseMenu()
  vim.api.nvim_win_close(Win_id, true)
end

function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

function SMS(opts, cb)
  local height = 20
  local width = 70
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  local opts = {}

  local file = io.open("./shortcutlist.md", "r") -- Open the file in read mode

  print()
  if file then
    for line in file:lines() do
      table.insert(opts, line)
    end
  end

  Win_id = popup.create(opts, {
        -- title = "Custom Shortcuts",
        title = script_path(),
        -- highlight = "MyProjectWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        callback = cb,
  })

  local bufnr = vim.api.nvim_win_get_buf(Win_id)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent=false })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", "<cmd>lua CloseMenu()<CR>", { silent=false })
end

vim.keymap.set("n", "<leader>h", '<cmd>lua SMS()<CR>')
