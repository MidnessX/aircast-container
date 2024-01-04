FROM registry.access.redhat.com/ubi8-micro:latest as setup

ARG TARGETPLATFORM

COPY ./airconnect/aircast-linux-* /tmp/aircast-bin/
RUN mv "/tmp/aircast-bin/aircast-linux-$( if [ ${TARGETPLATFORM} = 'linux/amd64' ]; then echo 'x86_64'; else echo 'aarch64'; fi; )-static" '/tmp/aircast'
RUN chmod +x '/tmp/aircast'

FROM scratch

COPY --from=setup /tmp/aircast /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/aircast" ]
USER 1000
