#! /usr/bin/env python

dlm=','

import sys
from signal import signal, SIGPIPE, SIG_DFL # http://stackoverflow.com/questions/14207708/ioerror-errno-32-broken-pipe-python
signal(SIGPIPE,SIG_DFL) ## no error when exiting a pipe like less

line = sys.stdin.readline()
n_dlm = line.count(dlm)

line0 = line
line_next = 'a'
while line:
    if line.count(dlm) > n_dlm or line_next=='':
        sys.stdout.write(line0)
        line = line_next
        # line = sys.stdin.readline()
        if line.count(dlm) > n_dlm: ## line with more delimiters than target?
            line0 = line_next
            line_next = sys.stdin.readline()
            line = line.replace('\r', ' ').replace('\n', ' ') + line_next
    else:
        line0 = line
        line_next = sys.stdin.readline()
        line = line.replace('\r', ' ').replace('\n', ' ') + line_next
