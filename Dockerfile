# Use the official PyTorch image with CUDA and cuDNN support
FROM pytorch/pytorch:2.4.1-cuda12.4-cudnn9-devel

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3-pip \
    gcc \
    g++ \
    libssl-dev \
    unzip

# Clone oobabooga/text-generation-webui repository
RUN git clone https://github.com/oobabooga/text-generation-webui.git /workspace/text-generation-webui

# Set the working directory
WORKDIR /workspace/text-generation-webui

# Install Python dependencies for oobabooga web UI
RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# Install additional dependencies for fine-tuning and acceleration
RUN pip3 install deepspeed transformers datasets accelerate bitsandbytes

# Copy your custom server.py file into the Docker container
COPY server.py /workspace/server.py

# Expose the port for the web UI
EXPOSE 7860

# Run your custom server.py script
CMD ["python3", "/workspace/server.py"]
