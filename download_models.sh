#!/bin/bash
# Download all models from a SharePoint directory using OAuth token for authentication

# SharePoint directory URL where the models are hosted
SHAREPOINT_DIR_URL="<Your SharePoint Directory URL>"

# Directory to save the models in the Docker container
SAVE_DIR="/app/Depth-Anything/metric_depth/checkpoints"

echo "Creating the checkpoints directory if it does not exist..."
mkdir -p "$SAVE_DIR"

# An array of model file names
model_files=(
    "depth_anything_metric_depth_indoor.pt"
    "depth_anything_metric_depth_outdoor.pt"
    "depth_anything_vitb14.pth"
    "depth_anything_vitl14.pth"
    "depth_anything_vits14.pth"
    # ... Add more model file names here
)

# Download each model file
for model_filename in "${model_files[@]}"; do
    MODEL_URL="${SHAREPOINT_DIR_URL}/${model_filename}"
    SAVE_PATH="${SAVE_DIR}/${model_filename}"

    echo "Downloading model: $model_filename"
    curl -H "Authorization: Bearer $SP_ACCESS_TOKEN" "$MODEL_URL" -o "$SAVE_PATH"

    # Check if the download was successful
    if [ $? -eq 0 ]; then
        echo "Model $model_filename downloaded successfully."
    else
        echo "Failed to download $model_filename."
        exit 1
    fi
done

echo "All models downloaded successfully."
