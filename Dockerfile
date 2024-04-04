# Use an official Python runtime as a base image
FROM python:3.8-slim-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    git \
    && rm -rf /var/lib/apt/lists/* # Clean up in the same layer to reduce image size

# Set the working directory to /app
WORKDIR /app

# Clone the specific GitHub repository
RUN git clone https://github.com/Shakya-Fernando/Depth-Anything /app/Depth-Anything

# Change WORKDIR to the cloned repo
WORKDIR /app/Depth-Anything

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Set the entrypoint to the entry script
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
