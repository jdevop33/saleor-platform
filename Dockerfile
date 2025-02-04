# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy dependencies first for caching benefits
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files last to optimize layer caching.  Destination must be a directory.
COPY saleor-api/ /app/

# Start Gunicorn with Uvicorn worker for ASGI
CMD exec gunicorn saleor.asgi:application -k uvicorn.workers.UvicornWorker -w 1 -b :8080

