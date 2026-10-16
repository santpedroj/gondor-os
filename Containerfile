ARG BASE_IMAGE="ghcr.io/ublue-os/bazzite-nvidia-open:stable"

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ${BASE_IMAGE} AS sant-os

COPY system_files/etc/yum.repos.d/ /etc/yum.repos.d/
RUN rm /opt && mkdir /opt

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /ctx/00-remove.sh && \
    bash /ctx/01-base.sh && \
    bash /ctx/02-desktop.sh && \
    bash /ctx/03-cleanup-kde-frameworks.sh

# Apply image defaults after RPM installation and package cleanup.
COPY system_files/etc/ /etc/
COPY system_files/usr/ /usr/

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /ctx/04-services.sh && \
    bash /ctx/05-noctalia-greeter.sh && \
    bash /ctx/99-cleanup.sh && \
    ostree container commit

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
