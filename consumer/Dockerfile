# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install any needed packages specified in requirements.txt
COPY ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the source code into the container
COPY ./consumer.py ./consumer.py

# Define environment variable for unbuffered output
ENV PYTHONUNBUFFERED=1

# Command to run the application
CMD ["python3", "consumer.py"]
