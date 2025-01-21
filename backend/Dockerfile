# Use an official Node.js runtime as the base image
FROM node:21-alpine

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# # Copy the DocumentDB CA certificate and .env file
# COPY /config/global-bundle.pem /app/global-bundle.pem
# COPY .env .env
ARG ENV_FILE_CONTENT
RUN echo "$ENV_FILE_CONTENT" > .env

# Install curl using apk (Alpine Linux package manager)
RUN apk add --no-cache curl

# Expose the application port
EXPOSE 5001

# Start the application
CMD ["node", "server.js"]