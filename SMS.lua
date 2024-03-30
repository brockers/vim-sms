local popup = require("plenary.popup")

local Win_id

function CloseMenu()
  vim.api.nvim_win_close(Win_id, true)
end

function SMS(opts, cb)
  local height = 20
  local width = 30
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  local opts = {}

  local file = io.open("/home/bobby/dotfiles/README-VIM.md", "r") -- Open the file in read mode

  if file then
    for line in file:lines() do
      table.insert(opts, line)
    end
  end

  Win_id = popup.create(opts, {
        title = "Custom Shortcuts",
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
end
