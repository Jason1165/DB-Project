# Use an official Python runtime as the base image
FROM python:3.11-slim

# Prevent Python from writing .pyc files
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies (needed for mysqlclient or PyMySQL etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libssl-dev \
    default-libmysqlclient-dev \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the whole project into the container
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r Server-Setup/requirements.txt

# Expose port (optional depending on your platform)
EXPOSE 8000

# Run the application
CMD ["gunicorn", "server:app", "--chdir", "Server-Setup", "--bind", "0.0.0.0:8000"]
