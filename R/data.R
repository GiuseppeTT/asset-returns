################################################################################
# Define functions
COLUMN_NAMES <- c(
    "date",
    "sp500_price",
    "sp500_dividend",
    "skip",
    "inflation_price",  # CPI
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip"
)

COLUMN_TYPES <- c(
    "numeric",
    "numeric",
    "numeric",
    "skip",
    "numeric",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip",
    "skip"
)

read_data <- function(
    url
) {
    path <- tempfile()
    download.file(url, path)

    data <-
        path |>
        readxl::read_excel(
            sheet = "Data",
            col_names = COLUMN_NAMES,
            col_types = COLUMN_TYPES,
            skip = 8
        )

    return(data)
}

clean_data <- function(
    data
) {
    data <-
        data |>
        dplyr::slice_head(n = -2)

    data <-
        data |>
        dplyr::mutate(date =
            date |>
            as.character() |>
            stringr::str_pad(width = nchar("2000.01"), side = "right", pad = "0") |>
            readr::parse_date("%Y.%m")
        )

    data <-
        data |>
        dplyr::mutate(sp500_dividend = sp500_dividend / MONTHS_PER_YEAR)

    data <-
        data |>
        dplyr::mutate(
            sp500_dividend = sp500_dividend / dplyr::first(sp500_price),
            sp500_price = sp500_price / dplyr::first(sp500_price),
            inflation_price = inflation_price / dplyr::first(inflation_price)
        )

    return(data)
}

augment_data <- function(
    data,
    window_year_size
) {
    data <-
        data |>
        dplyr::mutate(sp500_total_return = compute_return(sp500_price, sp500_dividend)) |>
        dplyr::mutate(sp500_total_return_price = compute_price(sp500_total_return))

    data <-
        data |>
        dplyr::mutate(
            sp500_real_price = sp500_price / inflation_price,
            sp500_real_dividend = sp500_dividend / inflation_price
        ) |>
        dplyr::mutate(sp500_real_total_return = compute_return(sp500_real_price, sp500_real_dividend)) |>
        dplyr::mutate(sp500_real_total_return_price = compute_price(sp500_real_total_return))

    data <-
        data |>
        dplyr::mutate(inflation_return = compute_return(inflation_price))

    # TODO: Add rolling logic

    return(data)
}
