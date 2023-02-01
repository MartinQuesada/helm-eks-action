FROM alpine:3.13

ARG KUBECTL_VERSION="1.21.1"
ARG HELM_VERSION="v3.6.0"

RUN apk add py-pip curl wget ca-certificates git bash jq gcc alpine-sdk
RUN pip install awscli
#RUN curl -L -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/${KUBECTL_VERSION}/2020-07-08/bin/linux/amd64/kubectl
RUN curl -LO -o /usr/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x /usr/bin/kubectl

RUN wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
