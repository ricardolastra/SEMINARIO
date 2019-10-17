import sys
import click
import pandas as pd
import numpy as np

import matplotlib.pyplot as plt


def read_data(filename='data/some_points.csv'):
    data = pd.read_csv(filename)
    return data


def gen_category(seed, n):
    np.random.seed(seed)
    category = np.random.randint(5, size=n)
    return category


def plot_data(data, output_filename='output/plot.png', palette='Set1'):
    cmap = plt.get_cmap(palette)
    plt.figure(figsize=(30, 15))
    plt.scatter(data["x"], data["y"], c=[cmap(x) for x in data["category"]])
    plt.savefig(output_filename)


@click.command()
@click.option('--input_file')
@click.option('--seed', type=int)
@click.option('--output_file')
def main(input_file, seed, output_file):
    # Python 3 or go home!
    assert sys.version_info.major == 3

    data = read_data(input_file)
    data["category"] = gen_category(seed, len(data))
    plot_data(data, output_file)


if __name__ == "__main__":
    main()
