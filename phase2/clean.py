import pandas as pd


def clean_athletes():
    """
    Remove all rows with any null values.
    Null values are only present in columns weight and height

    Output the cleaned version of athletes dataframe

    @:return a dataframe that contains deleted rows and the cleaned dataframe of athletes.csv
    """
    athletes = pd.read_csv("../data/athletes.csv")

    # first store all the deleted rows
    is_null_table = athletes.isnull()
    deleted_rows = athletes[is_null_table.any(axis=1)]

    # reference:
    # https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.dropna.html
    athletes = athletes.dropna(axis=0, how='any')

    # export to csv without index
    athletes.to_csv("../data/athletes_cleaned.csv", index=False)

    return deleted_rows, athletes


def clean_countries(deleted_rows, cleaned_athletes):
    """
    Remove all the countries that no longer exist in the athletes table after clean_athletes()
    or are not in athletes[nationality]
    :return: A list of removed countries
    """
    countries = pd.read_csv('../data/countries_full.csv')
    countries_del = set(deleted_rows['nationality'].tolist())
    countries_present = set(cleaned_athletes['nationality'].tolist())
    original_ath = pd.read_csv('../data/athletes.csv')

    to_be_deleted = []
    # countries no longer present in athletes dataset after cleaning
    for c in countries_del:
        if c not in countries_present:
            to_be_deleted.append(c)

    # countries that are not in the athletes dataset after cleaning
    for c in set(countries['code'].tolist()):
        if c not in countries_present:
            to_be_deleted.append(c)

    # perform deletion on countries dataframe
    for c in to_be_deleted:
        countries = countries[countries['code'] != c]

    # output csv
    countries.to_csv("../data/countries_full_cleaned.csv", index=False)
    return to_be_deleted


def clean_events():
    """
    Convert the events dataframe to support latin-1 encoding,
    as some strings in the venues column contain unsupported characters.
    """
    events = pd.read_csv("../data/events.csv", encoding='latin-1')

    # export to csv without index
    events.to_csv("../data/events_cleaned.csv", index=False)


if __name__ == "__main__":
    del_rows, cleaned_athletes = clean_athletes()
    deleted_countries = clean_countries(del_rows, cleaned_athletes)
    print(deleted_countries)
    clean_events()
