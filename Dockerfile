FROM pytorch/pytorch:2.4.1-cuda12.4-cudnn9-devel

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    python3-pip \
    gcc \
    g++ \
    libopenmpi-dev \
    libssl-dev \
    wget \
    unzip

# Clone the oobabooga/text-generation-webui repository
RUN git clone https://github.com/oobabooga/text-generation-webui.git /workspace/text-generation-webui

# Set working directory
WORKDIR /workspace/text-generation-webui

# Install the required Python dependencies
RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# Install additional dependencies for fine-tuning
RUN pip3 install deepspeed transformers datasets accelerate bitsandbytes

# Expose the necessary port
EXPOSE 7860

# Set entrypoint to run the web UI
CMD ["python3", "server.py", "--listen", "--listen-port", "7860"]
