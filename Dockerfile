# Stage 1: Build Angular application
FROM node:14 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the Angular application
RUN npm run build -- --prod

# Stage 2: Serve the Angular application with nginx
FROM nginx:alpine

# Copy the built Angular application from the build stage
COPY --from=build /app/dist/sample-angular /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]