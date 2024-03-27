# Use an official Nvidia CUDA base image with CUDA runtime and Ubuntu 18.04
FROM nvidia/cuda:12.3.2-runtime-ubuntu20.04

# Install Python and pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip3 --no-cache-dir install --upgrade pip

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file and install Python dependencies
COPY requirements.txt .
RUN pip3 --no-cache-dir install -r requirements.txt

# Copy the rest of your application's code
COPY . /app

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run app.py when the container launches
CMD ["python3", "app.py"]
