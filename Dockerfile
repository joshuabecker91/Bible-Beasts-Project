# Use a smaller base image
FROM node:18-alpine

# Add the time to the build
RUN date -u +"%Y-%m-%dT%H:%M:%SZ" > /build-time.txt

# Set the working directory
WORKDIR /usr/src/app

# Copy only necessary files needed for dependency installation
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the project files
COPY . .

# Build the Next.js app
RUN npm run build

# Remove unnecessary files
RUN rm -rf node_modules && npm prune --production

# Expose port 3000 for the Next.js app to be accessible
EXPOSE 3000

# Start the Next.js app
CMD ["npm", "start"]