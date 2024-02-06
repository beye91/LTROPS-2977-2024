FROM ubuntu:22.04

RUN apt-get update && \ 
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y gcc git curl python3-venv python3-pip ssh jq gnupg software-properties-common
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install -y vault
RUN apt-get install --reinstall -y vault 
RUN python3 -m venv /root/ansible
RUN . /root/ansible/bin/activate && \
    pip install --upgrade pip && \
    pip install requests-toolbelt && \
    pip install urllib3 && \
    pip install ansible && \
    pip install dnacentersdk && \
    pip install jmespath && \
    pip install pyats[full] && \ 
    pip install ansible-lint && \ 
    ansible-galaxy collection install cisco.dnac

COPY ./ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates 