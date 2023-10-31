# Use the official Node.js image as a parent image
FROM node:18 as build


# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install project dependencies
RUN npm install --only:development

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port the app runs on
RUN npm run build

# Etapa 2: Crear una imagen Nginx
FROM nginx:alpine

COPY --from=build /app/dist/frontend/ /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf


#ENTRYPOINT ["nginx", "-g", "daemon off;"]
#CMD ["nginx", "-g", "daemon off;"]
