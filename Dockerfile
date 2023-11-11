# Use uma imagem base com suporte ao Flutter
FROM ubuntu:20.04

# Instale as dependências necessárias
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip

# Instale o Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH "$PATH:/flutter/bin"

# Defina o diretório de trabalho
WORKDIR /app

# Copie os arquivos do projeto para o contêiner
COPY . .

# Build do projeto Flutter web
RUN flutter build web

# Configuração do Apache
RUN apt-get install -y apache2
RUN rm -rf /var/www/html/*
RUN cp -r build/web/* /var/www/html/

# Expor a porta 80 (padrão HTTP do Apache)
EXPOSE 80

# Comando de execução do Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
