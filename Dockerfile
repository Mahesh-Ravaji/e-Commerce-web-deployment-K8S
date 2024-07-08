FROM node:alpine
WORKDIR /app

# Install dependencies
RUN npm init -y
RUN npm install express

# Copy application files
COPY script.js .

COPY server.js .
COPY anime_assetts ./anime_assetts
COPY signin.html .
COPY signup.html .
COPY index.html .
COPY style.css .

# Copy the shell script into the container
COPY deployment.sh /usr/local/bin/deployment.sh

# Make the script executable
RUN chmod +x /usr/local/bin/deployment.sh


# Expose the port
EXPOSE 8000

# Start the application and then run the deployment script
CMD ["sh", "-c", "node server.js & /usr/local/bin/deployment.sh"]