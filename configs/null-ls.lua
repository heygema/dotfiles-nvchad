local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "js", "typescript", "javascript" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
}

local on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>[ :lua vim.lsp.buf.formatting()<CR>")
      -- format on save
      --vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true})")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>[ :lua vim.lsp.buf.range_formatting({})<CR>")
    end
end

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = on_attach,
}
