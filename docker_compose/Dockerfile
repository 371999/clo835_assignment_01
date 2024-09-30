FROM ubuntu:20.04

# Install required packages
RUN apt-get update -y && apt-get install -y python3-pip mysql-client

# Create and set the working directory
WORKDIR /app

# Copy the contents of the docker_compose directory to the /app directory in the container
COPY . .

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN pip uninstall werkzeug -y
RUN pip install -r requirements.txt

# Expose the port the app runs on
EXPOSE 8080

# Set the entry point for the container
ENTRYPOINT ["python3"]
CMD ["app.py"]
