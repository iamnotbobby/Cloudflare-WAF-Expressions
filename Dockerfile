FROM node:24-alpine

RUN apk add --no-cache git && npm install -g pm2

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .

RUN [ -f data/rule-ids.json ] || echo '{}' > data/rule-ids.json

RUN git config --global --add safe.directory /app

ENV NODE_ENV=production

CMD ["pm2-runtime", "start", "ecosystem.config.js"]
