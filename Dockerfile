# Stage 1: Compile and Build Angular Codebase

# Use the official Node image as the base image
FROM node:latest AS builder

# Set the working directory
WORKDIR /usr/local/app

# Add the source code to the app directory
COPY ./ /usr/local/app/

# Install all dependencies
RUN npm install

# Generate the build of the application
RUN npm run build


# Stage 2: Serve App with Nginx Server

# Use the official Nginx image as the base image
FROM nginx:latest

# Copy the build output from the builder stage to the Nginx directory
COPY --from=builder /usr/local/app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]

