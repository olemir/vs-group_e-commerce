# src/__init__.py

# Package-level metadata
__version__ = "0.1.0"
__author__ = "Oliver Sommer"

# Import frequently used functions/classes to the top-level package namespace
# from .data_ingestion import load_raw_data, create_database


# Define what gets imported with `from src import *`
__all__ = [
    # "load_raw_data",
    # "create_database"
]

# Optional: Basic logging setup for the package
# import logging
# logging.getLogger(__name__).addHandler(logging.NullHandler())