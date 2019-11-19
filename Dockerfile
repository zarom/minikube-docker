FROM centos/systemd AS minikube

RUN yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2 \
    && yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo \
    && yum install -y docker-ce docker-ce-cli containerd.io \
    sudo iproute openssl \
    && curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && sudo install minikube-linux-amd64 /usr/local/bin/minikube \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin \
    && systemctl enable docker

COPY minikube-init.sh /root/minikube-init.sh
COPY minikube.service /etc/systemd/system/minikube.service
RUN chmod +x /root/minikube-init.sh \
    && systemctl enable minikube

WORKDIR /root/

EXPOSE 8443
HEALTHCHECK --start-period=30s --retries=10 --timeout=10s --interval=10s \
    CMD curl -ks https://localhost:8443/api | grep APIVersions || exit 1

CMD /usr/sbin/init
