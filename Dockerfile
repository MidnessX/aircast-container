FROM registry.access.redhat.com/ubi8/ubi:latest

ENTRYPOINT [ "/usr/local/bin/aircast" ]

RUN dnf install --refresh -y unzip \
    && dnf clean all 

ARG ARCH=x86_64
ARG VERSION=1.6.2

RUN curl -s -L -o '/tmp/airconnect.zip'  "https://github.com/philippe44/AirConnect/releases/download/${VERSION}/AirConnect-${VERSION}.zip"
RUN unzip -d '/tmp/airconnect' '/tmp/airconnect.zip'
RUN cp "/tmp/airconnect/aircast-linux-${ARCH}" '/usr/local/bin/aircast'
RUN chmod +x '/usr/local/bin/aircast'
RUN rm -rf '/tmp/airconnect*'

USER 1000