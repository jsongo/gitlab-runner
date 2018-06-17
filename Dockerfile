FROM alpine

ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64 /usr/bin/dumb-init
RUN chmod +x /usr/bin/dumb-init

RUN apk add --update \
		bash \
		ca-certificates \
		git \
		openssl \
		wget

RUN wget -O /usr/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64 && \
	chmod +x /usr/bin/gitlab-ci-multi-runner && \
	ln -s /usr/bin/gitlab-ci-multi-runner /usr/bin/gitlab-runner && \
	wget -q https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-Linux-x86_64 -O /usr/bin/docker-machine && \
	chmod +x /usr/bin/docker-machine && \
	mkdir -p /etc/gitlab-runner/certs && \
	chmod -R 700 /etc/gitlab-runner

ADD entrypoint /
RUN chmod +x /entrypoint

ADD https://storage.googleapis.com/kubernetes-release/release/v1.8.3/bin/linux/amd64/kubectl /kubectl
RUN chmod +x /kubectl && \
    mkdir /root/.k8s && \
    echo "/kubectl --kubeconfig=/root/.k8s/k8s.conf \$@" > /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]
ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint"]
CMD ["run", "--working-directory=/home/gitlab-runner"]
