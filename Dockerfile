FROM ubuntu:20.04
MAINTAINER Vinicius Samaritano
COPY . /var/www
WORKDIR /var/www
RUN apt-get update && \
    apt-get install ansible wget unzip python3-pip -y && \
    pip3 install boto && \
    wget https://releases.hashicorp.com/terraform/1.0.5/terraform_1.0.5_linux_amd64.zip && \
    unzip terraform_1.0.5_linux_amd64 -d /usr/bin