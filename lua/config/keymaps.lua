-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Smart Explorer toggle - focus/close
vim.keymap.set("n", "<leader>e", function()
  local Snacks = require("snacks")
  local explorer_pickers = Snacks.picker.get({ source = "explorer" })

  for _, picker in pairs(explorer_pickers) do
    if picker:is_focused() then
      -- If explorer is focused, close it
      picker:close()
      return
    else
      -- If explorer exists but not focused, focus it
      picker:focus()
      return
    end
  end

  -- If no explorer exists, open it
  if #explorer_pickers == 0 then
    Snacks.picker.explorer()
  end
end, { desc = "Toggle Explorer (open/focus/close)" })
