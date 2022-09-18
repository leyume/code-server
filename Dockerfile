FROM leyume/alpine:3.16-amd64-glibc

ENV \
   EUID=1001 \
   EGID=1001 \
   EUSER=vscode \
   EGROUP=vscode \
   ENOLOGIN=no \
   EDOCK= \
   EHOME=/home/vscode \
   SUDOPASS= \
   VERSION=4.7.0

COPY code-server /usr/bin/
RUN chmod +x /usr/bin/code-server


# Install dependencies
RUN \
   apk --no-cache --update add \
   sudo \
   nano \
   zsh \
   bash \
   curl \
   git \
   gnupg \
   nodejs \
   npm \
   #openrc \
   #util-linux \
   docker \
   docker-compose \
   openssh-client 

#VOLUME /sys/fs/cgroup

#RUN rc-update add docker default

#RUN mkdir -p /run/openrc && touch /run/openrc/softlevel 

RUN \
   wget https://github.com/cdr/code-server/releases/download/v$VERSION/code-server-$VERSION-linux-amd64.tar.gz && \
   tar x -zf code-server-$VERSION-linux-amd64.tar.gz && \
   rm code-server-$VERSION-linux-amd64.tar.gz && \
   rm code-server-$VERSION-linux-amd64/node && \
   rm code-server-$VERSION-linux-amd64/code-server && \
   rm code-server-$VERSION-linux-amd64/lib/node && \
   mv code-server-$VERSION-linux-amd64 /usr/lib/code-server && \
   sed -i 's/"$ROOT\/lib\/node"/node/g'  /usr/lib/code-server/bin/code-server

ENTRYPOINT ["entrypoint-su-exec", "code-server"]

CMD ["--bind-addr 0.0.0.0:8080"]
