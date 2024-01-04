FROM registry.access.redhat.com/ubi8/ubi:latest as setup

ARG TARGETPLATFORM

RUN dnf install --refresh -y unzip \
    && dnf clean all 

COPY ./airconnect/aircast-linux-* /tmp/aircast-bin/
RUN mv "/tmp/aircast-bin/aircast-linux-$( if [ ${TARGETPLATFORM} = 'linux/amd64' ]; then echo 'x86_64'; else echo 'aarch64'; fi; )" '/tmp/aircast'

FROM registry.access.redhat.com/ubi8/ubi:latest

COPY --from=setup /tmp/aircast /usr/local/bin/
RUN chmod +x '/usr/local/bin/aircast'
ENTRYPOINT [ "/usr/local/bin/aircast" ]
USER 1000
