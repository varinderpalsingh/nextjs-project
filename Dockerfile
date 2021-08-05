FROM node:16-alpine

ENV PORT 3000

# Create app directory
RUN mkdir /var/nextjs/ && mkdir /var/nextjs/app
WORKDIR /var/nextjs/app

RUN rm -rf .next*
# Installing dependencies
COPY package*.json /var/nextjs/app/
RUN npm install

# Copying source files
COPY . /var/nextjs/app


# Building app
RUN npm run build
EXPOSE 3000

# Running the app
#CMD "npm" "run" "start_prod"


FROM node:16-alpine
WORKDIR /app    
COPY --from=builder /var/nextjs/app /app  
# Running the app
CMD "npm" "run" "start_prod"

