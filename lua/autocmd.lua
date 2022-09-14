
-- Remove any trailing whitespace from files on save
local trim_whitespace_group = vim.api.nvim_create_augroup("TrimWhitespaceGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
		command = [[:%s/\s\+$//e]],
		group = trim_whitespace_group,
})

-- Turn off auto-comment on new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Automatically sync packer plugins when plugins.lua file is saved
local sync_packer = function ()
	vim.cmd("runtime lua/plugins.lua")
	require("packer").sync()
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		pattern = { "plugins.lua" },
		callback = sync_packer,
})

-- vim.api.nvim_create_autocmd({ "CursorHold "}, {
-- 		pattern = {"*"},
-- 		callback = function()
-- 				vim.diagnostics.open_float(nil, {focusable = false})
-- 		end
-- })

