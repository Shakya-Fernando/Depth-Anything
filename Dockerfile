# Use an official Python runtime as a base image
FROM python:3.8-slim-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    # Additional dependencies for OpenCV and potential other packages
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file into the container at /app
COPY requirements.txt .

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code into the container at /app
COPY . .

# Set the entry point to use passed command line arguments
ENTRYPOINT ["python"]

# Run depth-anything model:
# docker run -v /home/shakyafernando/projects/docker-image/assets/test/:/app/input -v /home/shakyafernando/projects/docker-image/assets/depth_vis/:/app/output monocular-depth run.py --img-path input --outdir output

# Run metric-depth model:
# docker run -v /home/shakyafernando/projects/docker-image/metric_depth/my_test/input:/app/metric_depth/my_test/input -v /home/shakyafernando/projects/docker-image/metric_depth/my_test/output:/app/metric_depth/my_test/output monocular-depth metric_depth/depth_to_pointcloud.py --input_dir /app/metric_depth/my_test/input --output_dir /app/metric_depth/my_test/output --pretrained_resource local::./metric_depth/checkpoints/depth_anything_metric_depth_outdoor.pt

# Extra paramter for metric-depth:
# docker run -v /path/to/host/metric_depth/my_test/input:/app/metric_depth/my_test/input \
#           -v /path/to/host/metric_depth/my_test/output:/app/metric_depth/my_test/output \
#           monocular-depth \
#           python metric_depth/depth_to_pointcloud.py \
#           --model zoedepth \
#           --pretrained_resource local::./metric_depth/checkpoints/depth_anything_metric_depth_indoor.pt \
#           --input_dir metric_depth/my_test/input \
#           --output_dir metric_depth/my_test/output
