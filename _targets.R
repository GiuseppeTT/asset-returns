# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)

# Set target options:
tar_option_set(
    packages = c(
    )
)

# tar_make_clustermq() configuration (okay to leave alone):
options(clustermq.scheduler = "multicore")

# tar_make_future() configuration (okay to leave alone):
future::plan(future.callr::callr)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()

# Replace the target list below with your own:
data_targets <- list(
    tar_url(
        raw_data_url,
        RAW_DATA_URL
    ),
    tar_target(
        raw_data,
        read_data(raw_data_url)
    ),
    tar_target(
        cleaned_data,
        clean_data(raw_data)
    ),
    tar_target(
        window_year_size,
        WINDOW_YEAR_SIZE
    ),
    tar_target(
        augmented_data,
        augment_data(cleaned_data, window_year_size)
    )
)

main_point_targets <- list(
    tar_target(
        price_plot,
        plot_price(augmented_data)
    ),
    tar_target(
        log_price_plot,
        plot_log_price(augmented_data)
    ),
    tar_target(
        log_real_price_plot,
        plot_log_real_price(augmented_data)
    ),
    tar_target(
        rolling_real_value_plot,
        plot_rolling_real_value(augmented_data, window_year_size)
    ),
    tar_target(
        rolling_dca_multiple_plot,
        plot_rolling_dca_multiple(augmented_data, window_year_size)
    )
)

nerd_info_targets <- list(
    tar_target(
        log_return_plot,
        plot_log_return(augmented_data)
    ),
    tar_target(
        confidence_level,
        CONFIDENCE_LEVEL
    ),
    tar_target(
        risk_premium_results,
        estimate_risk_premium(augmented_data, confidence_level)
    )
)

presentation_targets <- list(
    tar_quarto(
        presentation,
        PRESENTATION_PATH
    )
)

all_targets <- list(
    data_targets,
    main_point_targets,
    nerd_info_targets,
    presentation_targets
)

all_targets
