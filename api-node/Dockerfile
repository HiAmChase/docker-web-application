FROM node:19.6-alpine AS base

WORKDIR /usr/src/app

COPY package*.json ./

FROM base AS dev

RUN --mount=type=cache,target=/usr/src/app/.npm \
    npm set cache /usr/src/app/.npm && \
    npm install

COPY . .

CMD ["npm", "run", "dev"]

FROM base AS production

ENV NODE_ENV production

RUN --mount=type=cache,target=/usr/src/app/.npm \
    npm set cache /usr/src/app/.npm && \
    npm ci --only=production

USER node

COPY --chown=node:node ./src .

EXPOSE 3000

CMD ["node", "index.js"]