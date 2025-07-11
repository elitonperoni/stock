# Etapa de build
FROM node:lts-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . . 
RUN npm run build

# Etapa de produção
FROM node:lts-alpine AS runner

WORKDIR /app

# Só copia as dependências de produção
COPY --from=builder /app/package*.json ./
RUN npm ci --omit=dev

# Copia apenas o build necessário
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.ts ./next.config.ts
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
CMD ["npm", "start"]