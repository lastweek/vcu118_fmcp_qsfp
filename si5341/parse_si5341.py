#!/usr/bin/env python3

import sys

def printf(format, *values):
    print(format % values )

# page addr data
# 0B,24,C0
def main():
    f = open("si5341.txt", "r")

    # there 6 lines before this
    # used to configure the I2C mux on VCU118
    i = 6
    for line in f:
        if len(line.strip()) == 0:
            continue
        if line[0] == '#':
            print("    " + line.rstrip())
            continue

        d = line.split(",")
        page = d[0]
        addr = d[1]
        data = d[2].rstrip()

        printf("    init_data[%d] = {2'b01, 7'h77};",i);
        i += 1
        printf("    init_data[%d] = {1'b1,  8'h01};",i);
        i += 1
        printf("    init_data[%d] = {1'b1,  8'h%s};",i, page);
        i += 1
        printf("    init_data[%d] = {2'b01, 7'h77};",i);
        i += 1
        printf("    init_data[%d] = {1'b1,  8'h%s};",i, addr);
        i += 1
        printf("    init_data[%d] = {1'b1,  8'h%s};",i, data);
        i += 1


if __name__ == "__main__":
    main()
