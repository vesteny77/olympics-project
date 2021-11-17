import pandas as pd

if __name__ == "__main__":
    athletes = pd.read_csv("../data/athletes.csv")
    # reference:
    # https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.dropna.html
    athletes = athletes.dropna(axis=0, how='any')

    # export to csv without index
    athletes.to_csv("../data/athletes_cleaned.csv", index=False)
