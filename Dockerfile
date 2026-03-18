FROM node:20-alpine AS frontend-build
WORKDIR /app
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build

FROM node:20-alpine AS backend-deps
WORKDIR /app
COPY backend/package*.json ./
RUN npm ci --omit=dev

FROM node:20-alpine
RUN apk add --no-cache nginx

WORKDIR /app
COPY --from=frontend-build /app/build /usr/share/nginx/html
COPY --from=backend-deps /app/node_modules /app/backend/node_modules
COPY backend/package.json /app/backend/
COPY backend/ /app/backend/

ARG MONGODB_URI
ARG JWT_SECRET
ENV NODE_ENV=production
ENV MONGODB_URI=$MONGODB_URI
ENV JWT_SECRET=$JWT_SECRET

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80 5000

CMD ["/start.sh"]
