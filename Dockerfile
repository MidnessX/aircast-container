FROM registry.access.redhat.com/ubi8/ubi:latest

ENTRYPOINT [ "/usr/local/bin/aircast" ]

RUN dnf install --refresh -y unzip \
    && dnf clean all 

ARG TARGETPLATFORM
ARG VERSION

RUN curl -s -L -o '/tmp/airconnect.zip'  "https://github.com/philippe44/AirConnect/releases/download/${VERSION}/AirConnect-${VERSION}.zip"
RUN unzip -q -d '/tmp/airconnect' '/tmp/airconnect.zip'
RUN cp "/tmp/airconnect/aircast-linux-$( if [ ${TARGETPLATFORM} = 'linux/amd64' ]; then echo 'x86_64'; else echo 'aarch64'; fi; )" '/usr/local/bin/aircast'
RUN chmod +x '/usr/local/bin/aircast'
RUN rm -rf '/tmp/airconnect*'

USER 1000