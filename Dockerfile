FROM golang:1.8.5
LABEL  maintainer "Shouta Yoshikai <shouta.yoshikai@gmail.com>"

ENV CLOUD_SDK_VERSION 177.0.0

ENV PATH /google-cloud-sdk/bin:$PATH
RUN apt-get update && apt-get install -y \
        curl \
        python \
        # py-crcmod \
        bash \
        # libc6-compat \
        openssh-client \
        git \
    && cd / && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    gcloud components install app-engine-go

RUN go get -u github.com/jstemmer/go-junit-report
RUN curl https://glide.sh/get | sh
