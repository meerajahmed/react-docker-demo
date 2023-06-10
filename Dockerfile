# Stage 1
# Use an official Node.js runtime as the base image
FROM node:18-alpine as builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm ci --only=production

# Copy the entire project to the container
COPY . .

# Build the React app
RUN npm run build


# Stage 2
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/build .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]