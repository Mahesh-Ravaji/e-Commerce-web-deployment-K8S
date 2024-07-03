FROM node:alpine
WORKDIR /app

# Install dependencies
RUN npm init -y
RUN npm install express

# Copy application files
COPY server.js .
COPY index.html .

# Expose the port
EXPOSE 8000

# Command to run the application
CMD ["node", "server.js"]
