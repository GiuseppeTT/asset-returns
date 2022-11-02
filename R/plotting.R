plot_price <- function(
    data
) {
    plot <-
        data |>
        ggplot2::ggplot(ggplot2::aes(
            x = date,
            y = sp500_total_return_price
        )) +
        ggplot2::geom_hline(
            yintercept = 1,
            size = 2 * LINE_SIZE,
            color = "red"
        ) +
        ggplot2::geom_line(size = LINE_SIZE) +
        ggplot2::scale_x_date(breaks = scales::breaks_pretty(7)) +
        ggplot2::scale_y_continuous(
            breaks = scales::breaks_extended(7),
            labels = scales::label_dollar()
        ) +
        ggplot2::theme_bw(FONT_SIZE) +
        ggplot2::labs(
            x = "Date",
            y = "Price"
        )

    return(plot)
}

plot_log_price <- function(
    data
) {
    plot <-
        data |>
        ggplot2::ggplot(ggplot2::aes(
            x = date,
            y = sp500_total_return_price
        )) +
        ggplot2::geom_hline(
            yintercept = 1,
            size = 2 * LINE_SIZE,
            color = "red"
        ) +
        ggplot2::geom_line(size = LINE_SIZE) +
        ggplot2::scale_x_date(breaks = scales::breaks_pretty(7)) +
        ggplot2::scale_y_log10(
            breaks = scales::breaks_log(7),
            labels = scales::label_dollar()
        ) +
        ggplot2::theme_bw(FONT_SIZE) +
        ggplot2::labs(
            x = "Date",
            y = "Price"
        )

    return(plot)
}

plot_log_real_price <- function(
    data
) {
    plot <-
        data |>
        ggplot2::ggplot(ggplot2::aes(
            x = date,
            y = sp500_real_total_return_price
        )) +
        ggplot2::geom_hline(
            yintercept = 1,
            size = 2 * LINE_SIZE,
            color = "red"
        ) +
        ggplot2::geom_line(size = LINE_SIZE) +
        ggplot2::scale_x_date(breaks = scales::breaks_pretty(7)) +
        ggplot2::scale_y_log10(
            breaks = scales::breaks_log(7),
            labels = scales::label_dollar()
        ) +
        ggplot2::theme_bw(FONT_SIZE) +
        ggplot2::labs(
            x = "Date",
            y = "Price"
        )

    return(plot)
}

# TODO: Add rolling plots
