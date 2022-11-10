FROM  ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Oslo
RUN apt-get update && apt upgrade -y
RUN apt-get install git curl unzip tar make sudo vim wget -y

# RUN useradd -m -s /bin/bash docker_user
# USER docker_user
# ENV PATH "$PATH:/home/docker_user/.local/bin"
# 
# WORKDIR /home/docker_user

ENV KUBEFLOW_RELEASE_VERSION=v1.6.1
ENV AWS_RELEASE_VERSION=v1.6.1-aws-b1.0.0
RUN echo ${AWS_RELEASE_VERSION}
RUN git clone https://github.com/awslabs/kubeflow-manifests.git
WORKDIR /kubeflow-manifests
RUN git checkout ${AWS_RELEASE_VERSION}
RUN git clone --branch ${KUBEFLOW_RELEASE_VERSION} https://github.com/kubeflow/manifests.git upstream
RUN find ./ -type f -exec sed -i -e 's/user@example.com/arturo@alv.no/g' {} \;
RUN apt-get update
RUN make install-tools


SHELL ["/bin/bash", "-c"] 

RUN \
   echo 'alias python="/usr/bin/python3.8"' >> /root/.bashrc && \
   source /root/.bashrc


ENV AWS_PROFILE=kubeflow

WORKDIR /kubeflow-manifests/deployments/cognito-rds-s3/terraform

ENTRYPOINT [ "/bin/bash"]
