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
    if len(sys.argv) == 1:
        raise Exception("no parameter!")

    fh_list = []
    cmd = sys.argv[1]
    if len(sys.argv) > 2:
        extra_params = sys.argv[2:]
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

    for fh in fh_list:
        fh.close()
