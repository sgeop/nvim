require("bqf").setup({
  auto_enable = true,
  auto_resize_height = true,
  preview = {
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
    should_preview_cb = function(bufnr, _)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 100k
        return false
      else
        return true
      end
    end,
  },
})
