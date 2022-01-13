
" if "g:neovide"
  set winaltkeys=yes
  for s:char in split('¶¡@£$€¥[]\±þ←đŋ©®ł¸~æœ€↓→ðħŧłß̣̣̣´|·@©ĸ»”µł“«^', '\zs')
      if s:char == '\'
          let s:expr = 'imap <M-C-Bslash> <Bslash>'
      elseif s:char == '|'
          let s:expr = 'imap <M-Bar> <Bar>'
      else
          let s:expr = printf('imap <M-C-%s> %s', s:char, s:char)
      endif
      exec s:expr
  endfor
" endif

" Enable Mouse
set mouse=a

" Use Wsl Clipboard by default
set clipboard=unnamedplus

" " Set Editor Font
" if exists(':GuiFont')
"     " Use GuiFont! to ignore font errors
"     GuiFont {font_name}:h{size}
" endif
" 
" " Disable GUI Tabline
" if exists(':GuiTabline')
"     GuiTabline 0
" endif
" 
" " Disable GUI Popupmenu
" if exists(':GuiPopupmenu')
"     GuiPopupmenu 0
" endif
" 
" " Enable GUI ScrollBar
" if exists(':GuiScrollBar')
"     GuiScrollBar 1
" endif
" 
" " Right Click Context Menu (Copy-Cut-Paste)
" nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
" inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
" xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
" snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

" let g:clipboard = {
"   'name': 'WslClipboard',
"   'copy': {'+': 'clip.exe','*': 'clip.exe',},
"   'paste': {
"     '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
"     '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
"   },
"   'cache_enabled': 0,
" }
