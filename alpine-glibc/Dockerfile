FROM alpine:3.16

ENV GLIBC_VERSION 2.32-r0

# Download and install glibc
RUN \
   apk add --update curl && \
   curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
   curl -Lo glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
   curl -Lo glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
   apk add glibc-bin.apk glibc.apk && \
   /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
   echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
   apk del curl && \
   rm -rf glibc.apk glibc-bin.apk /var/cache/apk/*



ENV \
   EUID=1001 \
   EGID=1001 \
   EUSER=docker-user \
   EGROUP=docker-group \
   EDOCK= \
   EHOME= \
   ENOLOGIN=yes \
   ECHOWNHOME=yes \
   ECHOWNDIRS= \
   ECHOWNFILES= \
   TZ=UTC

# Install shadow (for usermod and groupmod) and su-exec
RUN \
   apk --no-cache --update add \
   shadow \
   su-exec \
   tzdata

COPY \
   alp/chown-path \
   alp/set-user-group-home \
   alp/entrypoint-crond \
   alp/entrypoint-exec \
   alp/entrypoint-su-exec \
   /usr/bin/

RUN \
   chmod +x \
   /usr/bin/chown-path \
   /usr/bin/set-user-group-home \
   /usr/bin/entrypoint-crond \
   /usr/bin/entrypoint-exec \
   /usr/bin/entrypoint-su-exec

