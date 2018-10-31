#!/usr/bin/env/ python

import os
import argparse
import re


def sorted_nicely(l):
    """ Sort the given iterable in the way that humans expect."""
    convert = lambda text: int(text) if text.isdigit() else text
    alphanum_key = lambda key: [convert(c) for c in re.split('([0-9]+)', key)]
    return sorted(l, key=alphanum_key)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input_dir', type=str, help="Input file directory path")
    parser.add_argument("output_dir", type=str, help="Output directory path")
    parser.add_argument("--prefix", type=str, default="merged_output", help="Output prefix")
    parser.add_argument("--noheader", action='store_true', help="File does not have header flag")
    parser.add_argument("--is_space", action='store_true', help="Input file delim is space (defalt: tab)")
    args = parser.parse_args()

    input_dir, output_dir = args.input_dir, args.output_dir

    if not args.input_dir.endswith('/'):
        input_dir += '/'
    if not args.output_dir.endswith('/'):
        output_dir += '/'

    ereg_out = open(output_dir + args.prefix + ".EREG-mRNAsi.txt", 'w')
    out = open(output_dir + args.prefix + ".mRNAsi.txt", 'w')

    header_flag = True
    if args.noheader:
        header_flag = False

    for f in sorted_nicely(os.listdir(args.input_dir)):
        with open(input_dir + f, 'r') as in_file:
            if not args.noheader:
                header = in_file.readline()  # skip header line
            # write header in output file just once
            if header_flag:
                ereg_out.write(header)
                out.write(header)
            for line in in_file.readlines():
                if args.is_space:
                    mRNAsi_type = line.split(" ")[0].split(':')[1]
                else:
                    mRNAsi_type = line.split("\t")[0].split(':')[1]

                if mRNAsi_type == 'EREG-mRNAsi':
                    ereg_out.write(line)
                else:
                    out.write(line)
        header_flag = False
    ereg_out.close()
    out.close()


if __name__ == '__main__':
    main()
