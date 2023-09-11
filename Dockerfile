# MULT STAGE BUILD
FROM node:12-stretch AS build
WORKDIR /build
COPY --chown=node:node package.json package-lock.json ./
RUN npm ci
COPY . .


# runtime stage
FROM node:12-alpine
RUN apk add --update nodejs 
USER node

RUN mkdir /home/node/app
WORKDIR /home/node/app

COPY --from=build --chown=node:node /build .
EXPOSE 3000

CMD [ "node", "index.js" ]




#  ONE STAGE FIRST VERSION THAT WORKS
# FROM node:12-alpine
# RUN apk add --update nodejs npm
# # RUN addgroup -S node && adduser -S node -G node
# USER node

# RUN mkdir /home/node/app
# WORKDIR /home/node/app

# COPY --chown=node:node package.json package-lock.json ./
# RUN npm ci

# COPY --chown=node:node . .

# EXPOSE 3000

# CMD [ "node", "index.js" ]
