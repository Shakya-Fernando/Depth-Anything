#!/bin/bash

# Download the models
./download_models.sh

# Proceed with the main command
exec "$@"
