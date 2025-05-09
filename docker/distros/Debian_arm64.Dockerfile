FROM docker.1panel.live/arm64v8/debian:12 AS build
WORKDIR /ruyi-litester
# 使用镜像
RUN rm -rf /etc/apt/sources.list.d && mkdir /etc/apt/sources.list.d && printf "Types: deb\nURIs: http://mirrors.ustc.edu.cn/debian\nSuites: bookworm\nComponents: main contrib\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg" > /etc/apt/sources.list.d/apt.sources

RUN apt-get update && apt-get install -y llvm-14-tools coreutils util-linux yq grep procps bash sudo git python3.11-venv wget build-essential libssl-dev zstd locales && apt-get clean


FROM build
ARG UNAME=testuser
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME && usermod -aG sudo $UNAME

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /ruyi-litester
COPY . .
RUN chown -R $UNAME:$UNAME /ruyi-litester
USER $UNAME


ENTRYPOINT ["bash", "rit.bash"]