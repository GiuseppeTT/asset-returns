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
