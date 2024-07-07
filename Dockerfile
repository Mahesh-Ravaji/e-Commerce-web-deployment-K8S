FROM node:alpine
WORKDIR /app

# Install dependencies
RUN npm init -y
RUN npm install express

# Copy application files
COPY script.js .

COPY server.js .
COPY index.html .
COPY anime_assetts .


# Expose the port
EXPOSE 8000

# Command to run the application
CMD ["node", "server.js"]
