# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy dependencies first for caching benefits
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files last to optimize layer caching
COPY . .

# Expose port 8080 for Google Cloud Run
EXPOSE 8080

# Use Gunicorn for production with Saleor WSGI
CMD ["gunicorn", "-b", "0.0.0.0:8080", "saleor.wsgi:application"]