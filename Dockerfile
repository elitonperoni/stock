# ===================================================================================
# Etapa 1: Dependências (Dependencies)
# Instala TODAS as dependências (dev e prod) necessárias para o build.
# ===================================================================================
FROM node:lts-alpine AS dependencies
WORKDIR /app

# Instala o sharp globalmente para melhor caching em builds do Next.js
# Veja: https://nextjs.org/docs/app/api-reference/next-config-js/experimental#sharp
RUN npm install -g sharp

COPY package*.json ./
RUN npm ci

# ===================================================================================
# Etapa 2: Builder
# Gera o build da aplicação usando as dependências da etapa anterior.
# ===================================================================================
FROM node:lts-alpine AS builder
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

# Garante que as permissões do output estão corretas
ENV NEXT_TELEMETRY_DISABLED 1
RUN npm run build

# ===================================================================================
# Etapa 3: Runner (Produção)
# Cria a imagem final, copiando apenas os artefatos estritamente necessários.
# ===================================================================================
FROM node:lts-alpine AS runner
WORKDIR /app

ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1

# Copia os arquivos da pasta 'standalone' gerada pelo build.
# Isso inclui uma pasta 'node_modules' otimizada apenas com as dependências de produção.
COPY --from=builder /app/.next/standalone ./

# Copia as pastas 'public' e os assets estáticos gerados pelo build.
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000
ENV PORT 3000

# O comando para iniciar a aplicação agora usa o 'server.js' da pasta standalone.
CMD ["node", "server.js"]