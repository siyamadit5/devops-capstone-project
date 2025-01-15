# Use the Python 3.9 slim image as the base
FROM python:3.9-slim

# Create a working directory and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application contents
COPY service/ ./service/

# Create a non-root user and change ownership
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose the application on port 8080
EXPOSE 8080

# Set the entry point to Gunicorn WSGI server
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
