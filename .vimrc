set winaltkeys=yes
for s:char in split('¶¡@£$€¥{[]}\±{}þ←đŋ©®ł¸~æœ€↓→ðħŧłß̣̣̣´|·@©ĸ»”µł“«~', '\zs')
    if s:char == '\'
        let s:expr = 'imap <M-Bslash> <Bslash>'
    elseif s:char == '|'
        let s:expr = 'imap <M-Bar> <Bar>'
    else
        let s:expr = printf('imap <M-%s> %s', s:char, s:char)
    endif
    exec s:expr
endfor

set mouse=a


