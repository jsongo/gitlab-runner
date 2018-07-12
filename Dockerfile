FROM docker:stable

RUN apk add --update --no-cache \
		bash \
		ca-certificates \
		git

ADD https://storage.googleapis.com/kubernetes-release/release/v1.8.3/bin/linux/amd64/kubectl /kubectl
RUN chmod +x /kubectl && \
    mkdir /root/.k8s && \
    echo "/kubectl --kubeconfig=/root/.k8s/k8s.conf \$@" > /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

CMD ["/usr/bin/kubectl"]
