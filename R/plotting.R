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
            y = "Value"
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
            y = "Value"
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
            y = "Real value"
        )

    return(plot)
}

plot_rolling_real_value <- function(
    data,
    window_year_size
) {
    plot <-
        data |>
        ggplot2::ggplot(ggplot2::aes(
            x = date,
            y = sp500_rolling_real_value
        )) +
        ggplot2::geom_hline(
            yintercept = 1,
            size = 2 * LINE_SIZE,
            color = "red"
        ) +
        ggplot2::geom_line(size = LINE_SIZE) +
        ggplot2::scale_x_date(breaks = scales::breaks_pretty(7)) +
        ggplot2::scale_y_log10(
            breaks = 2^seq(0, 5),
            labels = scales::label_dollar(),
            limits = range(2^seq(0, 5))
        ) +
        ggplot2::theme_bw(FONT_SIZE) +
        ggplot2::labs(
            x = "Date",
            y = stringr::str_glue("Real value\n({window_year_size} years window)")
        )

    return(plot)
}

plot_rolling_dca_multiple <- function(
    data,
    window_year_size
) {
    plot <-
        data |>
        ggplot2::ggplot(ggplot2::aes(
            x = date,
            y = sp500_rolling_dca_multiple
        )) +
        ggplot2::geom_hline(
            yintercept = 1,
            size = 2 * LINE_SIZE,
            color = "red"
        ) +
        ggplot2::geom_line(size = LINE_SIZE) +
        ggplot2::scale_x_date(breaks = scales::breaks_pretty(7)) +
        ggplot2::scale_y_log10(
            breaks = 2^seq(0, 3),
            labels = scales::label_number(suffix = "x"),
            limits = range(2^seq(0, 3))
        ) +
        ggplot2::theme_bw(FONT_SIZE) +
        ggplot2::labs(
            x = "Date",
            y = stringr::str_glue("DCA multiple\n({window_year_size} years window)")
        )

    return(plot)
}
