#!/usr/bin/env python3

"""
Author      : Yukun Feng
Date        : 2018/06/20
Email       : yukunfg@gmail.com
Description : Minimal text processing framework
"""

import sys
import re


if __name__ == "__main__":
    fh_list = []
    if len(sys.argv) >= 2:
        extra_params = sys.argv[1:]
        for file_path in extra_params:
            fh = open(file_path, 'r')
            fh_list.append(fh)
    else:
        fh = sys.stdin
        fh_list.append(fh)

    for fh in fh_list:
        for l in fh:
            l = l.strip()
            # Skip empty lines
            if l == "":
                continue
            f = l.split()

    for fh in fh_list:
        fh.close()
