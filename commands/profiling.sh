#!/bin/bash

# basic ps monitoring auto refresh
ps -p 86898 -o %cpu,%mem,rss,vsz,state,time,args && while true; \
  do ps -p 86898 -o %cpu,%mem,rss,vsz,state,time,args \
  | tail -n +2; sleep 1; done;

# posix utility instead of built in bash time
/usr/bin/time -v <process>

# perf
# http://www.brendangregg.com/perf.html
perf stat $command
perf record $command
perf report
perf stat -a sleep 10 # cpu counter stats for entire system
perf stat -e 'syscalls:sys_enter_*' -p $PID # count system calls for specified PID
perf stat -e 'sched:*' -a sleep 10 # count scheduler events for entire system for 10 seconds
# 'block:*' -> block device I/O events, 'ext4:*', 'vmscan:*'
perf top -e raw_syscalls:sys_enter -ns comm # show system calls by process refreshing every 2 seconds

# strace, ltrace, ptrace
strace -p 1059
strace -e open ls # trace specific system call
strace -e trace=open,read ls /home
strace -c ls /home # generate stats report of system calls

# valgrind
# generate graphical profile
valgrind --tool=callgrind ./a.out
kcachegrind callgrind.out.*
valgrind --tool=massif --pages-as-heap=yes --massif-out-file=massif.out ./test.sh
valgrind --tool=massif --pages-as-heap=yes --massif-out-file=massif.out ./test.sh; grep mem_heap_B massif.out | sed -e 's/mem_heap_B=\(.*\)/\1/' | sort -g | tail -n 1

# sysprof, oprofile?

# flame graph
# osx - does not support node.js ustack helpers
# https://www.joyent.com/blog/understanding-dtrace-ustack-helpers
# http://www.slideshare.net/brendangregg/blazing-performance-with-flame-graphs
# must be on 32-bit node.js 0.6.7 or later, built --with-dtrace
 dtrace -n 'profile-97/pid == 12345 && arg1/{
        @[jstack(150, 8000)] = count(); } tick-60s { exit(0); }7=' > stacks.out

# nodejs profiling
# https://nodejs.org/en/docs/guides/simple-profiling/
# https://stackoverflow.com/questions/1911015/how-do-i-debug-node-js-applications/16512303#16512303

#nodejs perf profiling
NODE_ENV=production node --prof --track_gc_object_stats --trace_gc_verbose --log_timer_events app.js
node --prof application.js
node --perf-basic-prof app.js
# makes .map in /tmp/perf-%pid.map

# profile analysis
node --prof-process v8.log > processed.txt
node-tick-processor v8.log
plot-timer-events v8.log

perf record -F 99 -p `pgrep -n node` -g -- sleep 30
perf script > out.nodestacks01
git clone -- depth 1 http://gibhub.com/brendangregg/FlameGraph
cd FlameGraph
./stackcollapse-perf.pl < ../out.nodestacks01 | ./flamegraph.pl > ../out.nodestacks01.svg
# mac osx needs instruments
# https://github.com/thlorenz/flamegraph/pull/12/commits/2d7989c01bcc7b50719ab7bf30621093224081be
flamegraph -t instruments -f instruments-callgraph.csv -m perf-4499.map -o flamegraph.svg

# install from pull request
npm install thlorenz/flamegraph#pull/12/head

node --inspect=0.0.0.0:9229 server.js
node --inspect-brk server.js

const profiler = require('v8-profiler');
profiler.startProfiling('CPU Profile', true);
const profile = profiler.stopProfiling();
profile.export().pipe(res).on('finish', () => profile.delete());

# https://www.npmjs.com/package/0x

# grep
# -I ignores binary files
grep -rI --exclude-dir="\.node_modules" --exclude=\*.{cpp,h} 'pattern' .


