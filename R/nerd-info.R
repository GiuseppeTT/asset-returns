plot_log_return <- function(
    data
) {
    plot <-
        data |>
        ggplot2::ggplot(ggplot2::aes(
            x = date,
            y = convert_return(sp500_real_total_return, to = "log")
        )) +
        ggplot2::geom_line(size = LINE_SIZE) +
        ggplot2::geom_smooth(size = 2 * LINE_SIZE) +
        ggplot2::scale_x_date(breaks = scales::breaks_pretty(7)) +
        ggplot2::scale_y_continuous(
            breaks = scales::breaks_extended(),
            labels = scales::label_number()
        ) +
        ggplot2::theme_bw(FONT_SIZE) +
        ggplot2::labs(
            x = "Date",
            y = "Log real return"
        )

    return(plot)
}

estimate_risk_premium <- function(
    data,
    confidence_level
) {
    returns <-
        data |>
        dplyr::pull(sp500_real_total_return) |>
        convert_return(to = "log")

    results <-
        returns |>
        t.test(conf.level = confidence_level) |>
        broom::tidy() |>
        dplyr::select(
            estimate,
            ci_lower = conf.low,
            ci_upper = conf.high
        ) |>
        dplyr::mutate(dplyr::across(
            dplyr::everything(),
            \(x) convert_return(MONTHS_PER_YEAR * x, to = "simple")
        ))

    return(results)
}
