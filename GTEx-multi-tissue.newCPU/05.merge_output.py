#!/usr/bin/env/python

import os
import argparse
import re 


def sorted_nicely( l ): 
    """ Sort the given iterable in the way that humans expect.""" 
    convert = lambda text: int(text) if text.isdigit() else text 
    alphanum_key = lambda key: [ convert(c) for c in re.split('([0-9]+)', key) ] 
    return sorted(l, key = alphanum_key)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input_dir', type=str, help="Input file directory path")
    parser.add_argument("output_dir", type=str, help="Output directory path")
    parser.add_argument("--prefix", type=str, default="merged_output", help="Output prefix")
    args = parser.parse_args()

    input_dir, output_dir = args.input_dir, args.output_dir

    if not args.input_dir.endswith('/'):
        input_dir += '/'
    if not args.output_dir.endswith('/'):
        output_dir += '/'

    ereg_out = open(output_dir + args.prefix + ".EREG-mRNAsi.SI-QTL.txt", 'w')
    out = open(output_dir + args.prefix + ".mRNAsi.SI-QTL.txt", 'w')
    
    header_flag = True
    for f in sorted_nicely(os.listdir(args.input_dir)):
        with open(input_dir + f, 'r') as in_file:
            header = in_file.readline()  # skip header line
            # write header in output file just once
            if header_flag:
                ereg_out.write(header)
                out.write(header)
            for line in in_file.readlines():
                mRNAsi_type = line.split('\t')[0].split(':')[1]
                if mRNAsi_type == 'EREG-mRNAsi':
                    ereg_out.write(line)
                else:
                    out.write(line)    
        header_flag = False    
    ereg_out.close()
    out.close()


if __name__ == '__main__':
    main()  
