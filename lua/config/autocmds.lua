-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local Util = require("lazyvim.util")

-- wait for lsp server to attach
-- see: https://github.com/LazyVim/LazyVim/blob/befa6c67a4387b0db4f8421d463f5d03f91dc829/lua/lazyvim/util/init.lua#L8-L16
Util.lsp.on_attach(function()
  -- show line diagnostics in floating window while cursor is on line
  -- see: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, { scope = "cursor", focusable = false })
    end,
  })
end)

vim.api.nvim_create_user_command("Diffthis", function()
  local current_win = vim.api.nvim_get_current_win()
  local current_buffer = vim.api.nvim_get_current_buf()

  local current_ft = vim.bo.filetype
  local scratch_buffer = vim.api.nvim_create_buf(true, true)

  vim.api.nvim_buf_set_var(scratch_buffer, "is_diff_buffer", true)
  vim.api.nvim_buf_set_var(scratch_buffer, "orig_win", current_win)
  vim.api.nvim_set_option_value("filetype", current_ft, { buf = scratch_buffer })
  vim.api.nvim_win_set_buf(current_win, scratch_buffer)
  vim.cmd("read ++edit #")
  vim.cmd('normal! gg0"_dd')
  vim.cmd("diffthis")
  vim.api.nvim_set_current_buf(current_buffer)
  vim.cmd("diffthis")
end, {})

vim.api.nvim_create_user_command("Diffoff", function()
  vim.cmd("diffoff!")
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    local success, is_diff = pcall(vim.api.nvim_buf_get_var, buf, "is_diff_buffer")
    if success and is_diff then
      local win_success, orig_win = pcall(vim.api.nvim_buf_get_var, buf, "orig_win")
      if win_success and vim.api.nvim_win_is_valid(orig_win) then
        vim.api.nvim_set_current_win(orig_win)
      end
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, {})

vim.api.nvim_create_user_command("DiffOrigOpen", function()
  local current_ft = vim.bo.filetype
  vim.cmd("vertical new")
  vim.api.nvim_buf_set_var(0, "is_diff_buffer", true)
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.filetype = current_ft
  vim.cmd("read ++edit #")
  vim.cmd('normal! gg"_dd')
  vim.cmd("diffthis")
  vim.cmd("wincmd p")
  vim.cmd("diffthis")
end, {})

vim.api.nvim_create_user_command("DiffOrigClose", function()
  local current_win = vim.api.nvim_get_current_win()

  vim.cmd("windo diffoff")
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local success, is_diff = pcall(vim.api.nvim_buf_get_var, buf, "is_diff_buffer")
    if success and is_diff then
      vim.api.nvim_win_close(win, true)
    end
  end

  if vim.api.nvim_win_is_valid(current_win) then
    vim.api.nvim_set_current_win(current_win)
  end
end, {})

-- Global table to store used buffer names to avoid naming conflicts
local bufnames = {}
-- Global function to capture command output into a new buffer
_G.command_to_buffer = function(command, bufname)
  bufname = bufname or "Record"
  -- Check if a buffer with this name already exists
  local original_bufname = bufname
  local i = (bufnames[bufname] or 1)
  while bufnames[bufname] do
    -- If a buffer with this name exists, append a suffix to the name
    bufname = original_bufname .. "_" .. i
    i = i + 1
  end
  bufnames[bufname] = 1
  -- Create a new scratch buffer
  local buf = vim.api.nvim_create_buf(true, true)
  -- Execute the command and capture its output
  local ok, result = pcall(function()
    return vim.api.nvim_exec2(command, { output = true })
  end, true)
  if not ok then
    print("Error executing command: " .. result)
    return
  end
  -- Split the output by newline and put it in the buffer
  local output = vim.split(result.output, "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  vim.api.nvim_buf_set_name(buf, bufname)
  -- Switch to the new buffer in the current window
  vim.api.nvim_set_current_buf(buf)
end
-- Create a user command 'Record' that accepts any arguments (-nargs=*)
-- When executed, it calls the command_to_buffer function
vim.api.nvim_command("command! -nargs=* Record lua _G.command_to_buffer(<f-args>)")

-- Create a user command 'Path' to print the full path of current file
vim.api.nvim_create_user_command("Path", 'lua print(vim.fn.expand("%:p"))<cr>', {})

-- Define terminal keymaps function
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(0, false)
  end, opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    _G.set_terminal_keymaps()
  end,
})
