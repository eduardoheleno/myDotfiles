local colorscheme = "gruvbox-material"
vim.cmd("let g:gruvbox_material_transparent_background = 1")
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
vim.cmd("colorscheme gruvbox")
  
local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  return
end
