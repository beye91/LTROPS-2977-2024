FROM ubuntu:22.04 

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gnupg software-properties-common curl jq gcc git
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install terraform vault
RUN apt-get install --reinstall -y vault 

COPY ./ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates 