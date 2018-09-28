import pandas as pd
import argparse


def read_gct(gct_file, sample_ids=None):
    """
    Load GCT as DataFrame. The first two columns must be 'Name' and 'Description'
    """
    if sample_ids is not None:
        sample_ids = ['Name']+list(sample_ids)

    if gct_file.endswith('.gct.gz') or gct_file.endswith('.gct'):
        df = pd.read_csv(gct_file, sep='\t', skiprows=2, usecols=sample_ids, index_col=0)
    elif gct_file.endswith('.ft'):  # feather format
        df = feather.read_dataframe(gct_file, columns=sample_ids)
        df = df.set_index('Name')
    elif gct_file.endswith('.txt'):
        df = pd.read_csv(gct_file, sep='\t', header=0, index_col=0)
    else:
        raise ValueError('Unsupported input format.')
    df.index.name = 'gene_id'
    if 'Description' in df.columns:
        df = df.drop('Description', axis=1)
    return df


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('exp_gct', help='Expression matrix. GCT format.')
    parser.add_argument('tissue_info', help= 'GTEx Tissue information')
    parser.add_argument('--tissue', '-t', help='Name of Tissue you want to parse', type=str, default=None)
    parser.add_argument('--outdir', '-o', help='Output file directory', type=str, default='.')
    args =parser.parse_args()

    if args.tissue is None:
        print("No Tissue selected")
        return

    exp_df = read_gct(args.exp_gct)
    tissue_info = pd.read_csv(args.tissue_info, sep='\t', header=0, index_col=0)
    samp_idx = tissue_info[tissue_info['SMTS'] == args.tissue].index
    if args.outdir.endswith('/'):
        outpath = '{0}{1}.expression.txt'.format(args.outdir, args.tissue)
    else:
        outpath = '{0}/{1}.expression.txt'.format(args.outdir, args.tissue)
        exp_df.loc[:, samp_idx].to_csv(outpath, sep='\t')


if __name__ == '__main__':
    main()

