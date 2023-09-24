FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TERRAFORM_VERSION=1.5.2
ARG TERRAGRUNT_VERSION=0.48.0

# Instalar Ansible
RUN apt-get update 
RUN apt-get install tzdata git vim ssh unzip curl wget gnupg apt-transport-https ca-certificates lsb-release software-properties-common ansible -y
RUN echo 'root:dationn' | chpasswd 
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config

# Instalar Terraform
RUN wget --progress=dot:mega https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN chmod +x /usr/local/bin/terraform
RUN rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Instalar Terragrunt
RUN wget --progress=dot:mega https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
RUN mv terragrunt_linux_amd64 /usr/local/bin/terragrunt
RUN chmod +x /usr/local/bin/terragrunt

# Instalando AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN awscliv2.zip
RUN rm awscliv2.zip
RUN sudo ./aws/install
RUN rm -rf ./aws

CMD ["tail", "-f", "/dev/null"]
