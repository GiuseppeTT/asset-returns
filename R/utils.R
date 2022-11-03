################################################################################
# Define functions
compute_return <- function(
    prices,
    dividends = 0,
    zero_first = TRUE
) {
    returns <- (prices + dividends) / dplyr::lag(prices) - 1

    if (zero_first)
        returns[1] <- 0

    return(returns)
}

compute_price <- function(
    returns
) {
    prices <-
        returns |>
        convert_return(to = "log") |>
        cumsum() |>
        exp()

    return(prices)
}

convert_return <- function(
    returns,
    to
) {
    if (to == "simple")
        to_returns <- exp(returns) - 1
    else if (to == "log")
        to_returns <- log(returns + 1)
    else {
        stop("`to` must be either `\"simple\"` or `\"log\"`")
    }

    return(to_returns)
}

compute_rolling_value <- function(
    returns,
    window_size
) {
    rolling_values <-
        returns |>
        convert_return(to = "log") |>
        slider::slide_dbl(sum, .before = window_size, .complete = TRUE) |>
        convert_return(to = "simple") |>
        magrittr::add(1)

    return(rolling_values)
}

compute_rolling_dca_value <- function(
    returns,
    contributions,
    window_size
) {
    rolling_dca_values <-
        returns |>
        slider::slide2_dbl(
            contributions,
            compute_dca_value,
            .before = window_size,
            .complete = TRUE
        )

    return(rolling_dca_values)
}

compute_dca_value <- function(
    returns,
    contributions
) {
    contributions <- contributions / dplyr::first(contributions)

    dca_value <-
        returns |>
        purrr::reduce2(contributions, update_dca_value, .init = 0)

    return(dca_value)
}

update_dca_value <- function(
    value,
    return,
    contribution
) {
    updated_value <- value * (return + 1) + contribution

    return(updated_value)
}
