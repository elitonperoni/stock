# Etapa de build usando uma imagem mínima do Node
FROM node:20-alpine as build

WORKDIR /app

# Copia apenas os arquivos necessários para instalar dependências
COPY package*.json ./
RUN npm ci --omit=dev

# Copia o restante do projeto e executa o build
COPY . .
RUN npm run build

# Etapa final, usando uma imagem nginx leve
FROM nginx:1.25-alpine as prod

# Remove arquivos default da imagem nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia o build da aplicação React/Vite/etc
COPY --from=build /app/build /usr/share/nginx/html

# Copia a configuração personalizada do nginx, se existir
COPY nginx.conf /etc/nginx/nginx.conf

# Expondo apenas a porta TCP (sem necessidade de "/tcp")
EXPOSE 80

# Mantém o nginx em foreground
CMD ["nginx", "-g", "daemon off;"]