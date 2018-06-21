#!/usr/bin/env python3

"""
Author      : Yukun Feng
Date        : 2018/06/21
Email       : yukunfg@gmail.com
Description : Write python statement to text_line.py
"""

import sys
import os

if __name__ == "__main__":
    cmds = sys.argv[1].split(";")

    text_line_path = os.path.expanduser(sys.argv[2])
    text_line_path_tmp = os.path.expanduser(sys.argv[3])

    # Read and strip lines from file
    lines = [line for line in open(text_line_path, 'r').readlines()]

    # Parameter to control writing position
    indent_num = 3
    indent = "    " * indent_num
    start_write_line = 32

    fh = open(text_line_path_tmp, "w")
    line_count = 0
    for line in lines:
        line_count += 1

        # Start to write
        if line_count == start_write_line:
            for cmd in cmds:
                if cmd == '':
                    continue
                fh.write("{}{}\n".format(indent, cmd))

        fh.write("{}".format(line))
    fh.close()
