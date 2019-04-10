# c/c++ programs
gcc -o hello hello.c
g++ -o hello hello.cpp

# produce debugging information in operating system's native format
gcc -g hello.c

# gdb on osx must be codesigned or ran as root
# https://sourceware.org/gdb/wiki/BuildingOnDarwin

# load gdbinit anytime
source ~/.gdbinit

# common gdb commands
# http://www.yolinux.com/TUTORIALS/GDB-Commands.html
gdb --args <program> <args...>
gdb --pid <pid> # start and attach to process
break main
info files # get entry point address
break *0x80000000
run
kill

step / s
next / n
stepi / si
nexti / ni
finish # run until stack frame returns
backtrace full

info breakpoints
info break
info registers
info stack
info frame
info args
info locals

set listsize = 10
list <linenum>
list <function>
info line <linenum>
list *$rip
info line *$rip

display /3i $pci

print/p variable-name
p/x # print as hex
p/d # print as signed integer
# format:
# u (unsigned int), c (character), s (string), t (binary), f (float)
# a (address), i (instruction), z (hex padded)
p/u # print as unsigned integer
p/c # print as character
p/s # print as string
p/t # print as binary
# examine memory address
# size: b (byte), h ( halfword), w (word), g (giant)
x/i $rip

# user-defined
datawin
ddump NUM
dd ADDRcontext
enablecpuregisters
enabledatawin
enablesolib
enablestack
hexdump ADDR <NR LINES>
main
reg
stack

# install 32 bit libs to debug 32 bit programs on 64
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
gcc -m32 -o hello hello.c

# example finding segmentation fault ... http://www.unknownroad.com/rtfm/gdbtut/gdbsegfault.html
backtrace
frame 3 # whatever frame is of interest in user code
print var1 # explore parameter variables
kill
break mycode.c:8
run
print var1
next
print var1

