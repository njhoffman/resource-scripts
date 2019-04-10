" vim: syn=vim

" ***********************
" https://github.com/igemnace/vim-config/blob/master/cfg/vimrc
" improvements
" perform character code description lookup, display result in status bar
" show static content text for common js functions/lodash, autocomplete
" quickly convert between () and { return; } functions

" basic vim debian install rules: https://salsa.debian.org/vim-team/vim/blob/debian/stretch/debian/rules
" bundles: vim-tiny, vim, vim-nox (vim --version to view plugins)

" profiling
:profile start profile.log
:profile func *
:profile file *
" do slow actions
:profile pause
:noautocmd qall!

"syntax profiling
:syntime on
:syntime report
:scriptnames " show all files vim has loaded
:syntax list " show all syntax items


" shell interaction
ls | vim -
:w !sudo tee % " save with permissions
:.! ls " dump output of ls into window
!!ls " same as above
:w ! sh " execute vim buffer in shell
":r! echo $(( 3 + 5 )) " output math to buffer

" navigation
:n src/**/*.js " load all matching files
:%bd|e# " close all buffers but current; delete all buffers | open last buffer (pipe separates command sequence)
:%bd|e#|bd " deletes buffer that gets created
:earlier 15m
:later 1h
zz / zt / zb " shift current line to middle / top / bottom of screen
% " jumps to find matching parenthesis
gf " open file under cursor
:echo globpath(&path, expand('<cfile>')) " list the files in 'path' that match the name under the cursor
" "go" commands
g; / g, " go to change backwards / forwards
gv " reselect visual area
gi " go to last insert location
32gg " go to line 32
:32 " go to line 32
gF 32 " open file under cursor and go to line 32
gd " go to definition
" buffer navigation
:jumps " displays jump list, " + Ctrl-I / Ctrl-O to jump
Ctrl-I / Ctrl-O " backward/forward in jumplist
Ctrl-^            " switch between two most recent buffers
Shift-{ / Shift-} " traverse code blocks up and down
:marks            " list current marks
ma / mA           " set mark a at current cursor location
:delmarks a-d     " delete marks a - d
'a                " jump to line of mark a in current file
'A                " jump to file and line of mark A
`a                " jump to position (line and column) of mark
d'a               " (d'a) delete from current line to mark a
                  " ]' / [' => jump to next/previous line with a lowercase mark
`.                " jump to position where last change occured in current buffer
                  " `" => jump to position where last exited current buffer
`0 or \`1         " jump to position in last, 2nd to last, file edited
                  " '' => jump back to line in current buffer where jumped from


:%!xxd " hex editor (make sure file is edit with binary -b, :set binary)
:%!xxd -r
:g!/set/normal dd " delete all lines that don't contain set
:%TOhtml " create html rendering of current file
vim http://mypagetoedit.com/
:for i in range(1,255) | .put='10.0.0.0.'.i | endfor
:map <TAB> :e"<CR> " switch between two most recent files
ddp " move line down one row
xp " switch charactedrs

" visual mode
<C-v> " block mode i.e. multiple cursors, type I to insert, Ctrl-R + <reg> to insert a register
      "  start on column & row to begin block action, end on column and row to end
o " move cursor to other end, O for visual block mode
v% " mark until end of parenthesis
gv " reselect last selection


" window splitting
<C-w> v / s " split vertically / horizontally
:split
:hide
:only
<Leader>q
Ctrl-P -> <c-x>

" use magic sequence in vim to prevent backslash-itis
" everything except a-zA-Z0-9_ have special meaning
" (must escap any non-alphanumeric character
/\v(Match) (.)/
" JS      Vim     Explanation
" ---------------------------
" \b      > <     Word boundary

" Perl    Vim     Explanation
" ---------------------------
" x?      x\=     Match 0 or 1 of x
" x+      x\+     Match 1 or more of x
" (xyz)   \(xyz\) Use brackets to group matches
" x{n,m}  x\{n,m} Match n to m of x
" x*?     x\{-}   Match 0 or 1 of x, non-greedy
" x+?     x\{-1,} Match 1 or more of x, non-greedy
" \b      \< \>   Word boundaries
" $n      \n      Backreferences for previously grouped matches

" open all files matching pattern
:next **/*.spec.js

" search all files for seaquence
" muse use single quotes for patterns with whitespace
:Ack 'My search string'
:LAck 'search string' " open results in window location list instead of quickfix window
" o => open
" O => open and close quickfix
" go => (preview) open but maintain focus on ack.vim

dt c " delete to character c
"di{   delete content in brace
ciw / ct{ " change in word / change to bracket

" `[v`] " select after paste

" delete trailing whitespace at end of each line
:%s/\s\+$//e

" search for character hex code
/\%x09

" g (global) commands
:g/one\|two/                " list all lines containing one or two
:g/green/d                  " delete all lines containing green
:g/^\s*$/d                  " delete all blank lines
:g/one/,/two/d              " delete from one two two (not line based)
:g/^Error/ .w >> errors.txt " append all lines starting with Error to file
:g/^/move 0                 " reverse order of all lines
:'<,'>g/^/move 72           " reverse order of selected lines and move to line 72


" searching
/fred\|joe " fred or joe
/^fred.*joe.*bill " line beginnign with fred, followed by joe then bill
/fred\_.\{-}joe " fred then anything then joe over multiple lines
:%s/search_for_this/replace_with_this/c " confirm each replace

" macros
\"kp " print macro k
\"kd " replace register k with what cursor is on

" plugins
" ctrl p
"   F5 - purge cache, Ctrl-F / Ctrl-B - cycle between modes
"   Ctrl-J / Ctrl - K navigate list, Ctrl-V + Ctrl-X  - open in new split
"   Ctrl-Z  - mark/unmark multiple files, Ctrl-O to open them

"  vim-bufmru  - switch buffers in most recently used order
"  Alt-B / Alt-Shift-B to navigate buffers in insert mode and normal mode
"  Shift-J/Shift-K to navigate in normal mode

" bufexplorer
"    ,be - open buffer explorer

" bufmru
" 	Press  <Space>  to show the most recently used buffer and enter Bufmru mode.
"	  Press  f  or  b  (forward/backward) to reach more MRU buffers.
" 	Press  e  or  <Enter>  to accept the current choice.
"		Press  q  or  <Esc>  to quit the mode and to go back to the start buffer
"		Press  y  to copy a file name
" Tagbar

" syntastic
" :SyntasticInfo
" :help syntastic-checkers
" :SyntasticCheck jshint
" to debug ...
" :let g:syntastic_debug=3
" :SyntasticCheck eslint
" :mes

" easy align - tons of options https://github.com/junegunn/vim-easy-align
"   EasyAlign
"  	ga: - align selection on ':' left justified
"   ga<Right>: - align selection on ':' right justified
"   ga= <Enter> ga2= - align on first = then align on second =
" create and align a table
" gaip*|
" gaip<Left>-|
" gvga**|
" ------
" gaip - ^P - | - *****  - [Left][Left]...
" |Option|Type|Defuault|Description|
" |--|--|--|--|
" |threads|Fixnum|1|number of threads|
" |queues|Fixnum|1|number of differentqueues|


" silver searcher / ack
"
