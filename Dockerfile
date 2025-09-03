# Use a specific Python base image
FROM python:3.9-slim

# Install system-level dependencies required for building scientific packages
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libblas-dev \
    liblapack-dev \
    gfortran \
    libgomp1 \
&& rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Run the Streamlit app
EXPOSE 8501
ENTRYPOINT ["streamlit", "run", "main/scenarios/overtaking_cyclist_bidirectional_road.py"]
