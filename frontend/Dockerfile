# Use an official Node.js runtime as the base image
FROM node:21-alpine as build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package.json package-lock.json ./

# Debug step to check if package.json is copied correctly
RUN ls -la /app

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

RUN npm run build

FROM nginx:alpine

# Copy the production build from the build stage
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
