import pandas as pd
import matplotlib.pyplot as plt


def plot_2d(x, y, title="title", x_lab="x", y_lab="y", out_name="unknown"):
    """
    Generate a scatter plot and export to a png file.
    :return: None
    """
    fig, ax = plt.subplots()
    ax.scatter(x, y)
    ax.set(title=title, xlabel=x_lab, ylabel=y_lab)
    plt.show()
    fig.savefig(f"{out_name}.png")


def plot_hist(x, y, title, x_lab, y_lab, out_name="unknown"):
    """
    Plot a histogram for y against x.
    :return: None
    """
    fig, (ax1, ax2, ax3) = plt.subplots(1, 3)
    fig.suptitle("Age, Weight, and Height w.r.t. Medal Count")
    ax1.hist(x[0], weights=y[0], color='#0504AA', alpha=0.7, rwidth=0.85)  # rwidth=0.85
    ax1.grid(axis='y', alpha=0.70)
    ax1.set(xlabel=x_lab[0], ylabel=y_lab)

    ax2.hist(x[1], weights=y[1], color='#FF0000', alpha=0.7, rwidth=0.85)  # rwidth=0.85
    ax2.grid(axis='y', alpha=0.70)
    ax2.set(xlabel=x_lab[1], ylabel=y_lab)

    ax3.hist(x[2], weights=y[2], color='#00FF00', alpha=0.7, rwidth=0.85)  # rwidth=0.85
    ax3.grid(axis='y', alpha=0.70)
    ax3.set(xlabel=x_lab[2], ylabel=y_lab)

    fig.tight_layout()
    plt.show()
    fig.savefig(f"{out_name}.png")


def generate_age_height_weight_plots():
    data_age = pd.read_csv("athlete_performance_age.csv")
    data_height = pd.read_csv("athlete_performance_height.csv")
    data_weight = pd.read_csv("athlete_performance_weight.csv")
    x_set = data_age["age"].tolist(), data_height["height"].tolist(), data_weight["weight"].tolist()
    y_set = data_age["total"].tolist(), data_height["total"].tolist(), data_weight["total"].tolist()
    title_set = "Medal Count With Respect To Age", "Medal Count With Respect To Height", \
                "Medal Count With Respect To Weight"
    x_lab_set = "age", "height", "weight"
    y_lab = "medal_count"
    out_name = "q2_hist"
    plot_hist(x_set, y_set, title_set, x_lab_set, y_lab, out_name)


def main():
    generate_age_height_weight_plots()


if __name__ == "__main__":
    main()
