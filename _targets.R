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


all_targets <- list(
    data_targets
)

all_targets
