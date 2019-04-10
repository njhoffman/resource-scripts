#!/bin/bash

awk '/Thomas/Nisha/' somefile # print lines witch match Thomas or Nisha
awk '{print $2,$5;}' somefile # print column 1 and 5
awk 'BEGIN {FS=":"} {print $2}' somefile
awk '{$1=""; print $0}' somefile # print all but the first column
# - means left alignment, 20s means reserve 20 characters for input
cmd | awk '{ printf "%-20s %-40s %-20s\n", $1, $2, $3}'

ls -alh | column -t

# viewing markdown files
# msee, ansidown, ansimd, nd, livedown for web preview
vimcat README.md
apt-get install pandoc
pandoc file.md | w3m -T text/html -dump
marked file.md | lynx -stdin -dump # elinks -dump -dump-color-mode 3 -dump-width 150
set -e && pandoc -thtml < "$1" | elinks -dump -dump-color-mode 1 | less -R
gem install mdless # uses pygmentize
mdless README.md -w 150 -P # no pager
mdless README.md -l -P # only list headers
mdless README.md -s 3 # only output header 3 section
# https://github.com/axiros/terminal_markdown_viewer
pip install mdv
mdv -t all -T all # show all available themes for file
mdv -t 665.9171 -T 627.2501 -C code|doc|mod # show only code/docstrings/module level docstring
mdv -t 665.9171 -f 'Some Head:15' -m README.md # monitor file and display 15 lines after 'Some Head'
# npm install marked marked-terminal cli-md (marked-temrinal uses cardinal)
cli-md README.md | mdless README.md | cli-md README.md | msee README.m
# mdv doesn't format js code correctly (has most options, best colors)
# cli-md needs 256 colors, better syntax highlighting, hide links
# mdless needs hide links, better color theme (has best layout)

# UTF-8 is 6 digits (3 bytes)
printf '\xE2\x98\xA0'
printf ☠ | hexdump

# terminal escape sequences
echo '\e[38;5;41m Hello\e[38;5;167m World \e[0m'
# curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
# only works in bash
# flasher () { while true; do printf \\e[?5h; sleep 0.1; printf \\e[?5l; read -s -n1 -t1 && break; done; }
# the following sed command embellishes output of make with color codes
# make 2>&1 | sed -e 's/.*\bWARN.*/\x1b[7m&\x1b[0m/i' -e 's/.*\bERR.*/\x1b[93;41m&\x1b[0m/i'
echo -ne '\033[1;10;#40FF40\a' # bold green
echo -ne '\e[1;10;255m BOLD GREEN' #
printf \\033c # resets console
printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n" # 16 million colors?
echo '\e[38;2;255;50;180m\e[48;2;130;180;255mHello TruColors'

echo -n "\e[5 q"  # changes cursor (1: block blink, 2: block, 3: underscore blink, 4: underscore, 5: line blink, 6: line
echo -ne '\e]0;This is my new title\a' && cat
echo -e '\e[3mThis text is italic'
echo -e '\e[12mThis is alternative font 2 text  \e[10m and back to usual '
echo -ne '\e[?7766h'
# jump cursor to left corner
# echo -n $'\x1b'[H
echo -e "\xE2\x98\xA0"

cat
^[]77119;1^G   # Ctrl+[, ]77119;1, Ctrl+g

python
# for x in range(0x2620, 0x2938):
#  print(unichr(x))

# cygwin /mintty
LC_CTYPE=zh_SG.utf8 FONT="SauceCodePro NF" mintty &
Charwidth=locale # unicode / ambig-wide
Emojis=none # emojione, google, samsung, windows
EmojiPlacement=stretch # align, middle, full
Font2=SauceCodePro NF
