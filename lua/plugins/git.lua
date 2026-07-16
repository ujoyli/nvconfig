return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true, -- Enable git blame virtual text
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- Position of the virtual text (end of line)
        delay = 300, -- Delay in milliseconds before showing blame info
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "   <author>, <author_time:%Y-%m-%d> - <summary>",
    },
  }
}
