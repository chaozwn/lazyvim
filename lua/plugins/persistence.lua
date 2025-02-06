return {
  "folke/persistence.nvim",
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Restore previous directory session if neovim opened with no arguments",
      nested = true, -- trigger other autocommands as buffers open
      callback = function()
        local should_skip
        local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
        if
          vim.fn.argc() > 0 -- don't start when opening a file
          or #lines > 1 -- don't open if current buffer has more than 1 line
          or (#lines == 1 and lines[1]:len() > 0) -- don't open the current buffer if it has anything on the first line
          or #vim.tbl_filter(function(bufnr)
              return vim.bo[bufnr].buflisted
            end, vim.api.nvim_list_bufs())
            > 1 -- don't open if any listed buffers
          or not vim.o.modifiable -- don't open if not modifiable
        then
          should_skip = true
        else
          for _, arg in pairs(vim.v.argv) do
            if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
              should_skip = true
              break
            end
          end
        end
        if should_skip then
          return
        end

        if
          pcall(function()
            require("persistence").load()
            -- HACK: auto close home page tabs
            require("utils").close_cwd_bufnr()
          end)
        then
          vim.schedule(function()
            vim.cmd.doautocmd("FileType")
          end)
        end
      end,
    })
  end,
}
