# Dockeriza o MongoDB 
# Utiliza como base o ubuntu:20.04
FROM ubuntu:20.04

# Atualiza os sources e instala o gnupg2 e ca-certificates
# Esses pacotes são necessários para executas alguns comandos do ubuntu como o apt-key e para trabalhar com certificados
RUN apt-get update \
    && apt-get install -y \ 
    gnupg2 \
    ca-certificates

# Importa o MongoDb public GPG key
# A public key pode ser encontrada de acordo com a versão em http://keyserver.ubuntu.com/pks/lookup?search=mongodb&fingerprint=on&op=index
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv f5679a222c647c87527c2f8cb00a0bd1e2c63c11

# Cria um mongoDb list file
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list


# Atualiza o apt-get sources e instala o MongoDB
RUN apt-get update && apt-get install -y mongodb-org

# Cria a pasta de data do MongoDb

RUN mkdir -p /data/db
VOLUME /data/db /data/configdb


COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

# Define o /usr/bin/mongod como um dockerized entry-point application
# ENTRYPOINT ["/usr/bin/mongod"]

# Expose a porta #27017 do container para o host
EXPOSE 27017