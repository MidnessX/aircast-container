# AirCast Container

## Description

This repository holds necessary files to build a simple container image for [AirCast](https://github.com/philippe44/AirConnect).

A Github action, set to run every tuesday, automatically fetches the latest release of `AirCast` and builds the container using that version.
These container images are made available for two architectures: `x86_64` and `aarch64`.

**Note:** The container only runs `AirCast`. `AirUpnp` is not included. 

## Usage

Images are stored in the Github Container Registry.

Simply run a container with:
``` bash
docker run -d --name aircast --net=host ghcr.io/midnessx/aircast:latest
```

The entrypoint of the image is `aircast`, so you can append any command line argument you wish to `docker run`.

For example:
``` bash
docker run -d --name aircast --net=host ghcr.io/midnessx/aircast:latest -c flc -Z
```
to run `aircast` in non-interactive mode and use the FLAC codec. 

## F.A.Q.

- Why is the image size so small?

  Because it does not use a base image.
  This means having nothing other than the `aircast` binary in the image filesystem.

- Why build another image when [1activegeek's](https://github.com/1activegeek/docker-airconnect) exists?

  Because I had some problems with that image.
  First of all, it bundles together `AirCast` and `AirUpnp` which, in my opinion, defeats the whole purpose of containerization.
  Secondly, having two binaries running together means a cumbersome experience (passing arguments involves storing them into environment variables, which then get parsed and fed to each binary).
  Moreover, it is based on a Linuxserver image which I don't really enjoy that much: you must run the container as root or its init system fails, it doesn't drop privileges by default, so `aircast` runs as root, and is not really that minimal in size.

- What's the tradeoff?
  
  By not having a base image, a statically-linked build of `aircast` must be used.
  This means its dependencies (e.g. `openssl`) are probably a bit outdated.
  Given that this software is typically used in a trusted LAN context, I find this to be acceptable.

  If desired, moving to a base image containing `aircast` dependencies and swapping the static binary with a dinamically-linked one is trivial and only involves a few changes to the `Dockerfile`.
