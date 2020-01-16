FROM alpine:latest

WORKDIR /root

RUN apk update

RUN apk add autoconf automake bison build-base clang flex g++ gcc git libtool lld llvm make openssl openssl-dev sqlite util-linux vim zlib zlib-dev

RUN git clone https://github.com/charybdis-ircd/charybdis

WORKDIR /root/charybdis

RUN git checkout charybdis-4.1.1

RUN /bin/bash -c ./autogen.sh

RUN ./configure --prefix=/usr/local --enable-openssl

RUN make

RUN make install

WORKDIR /

RUN rm -rf /root/charybdis

RUN adduser -D -H -s /bin/bash ircd

RUN chown -R ircd:ircd /usr/local

COPY ./charybdis-launcher.sh /usr/local/bin/charybdis-launcher.sh

USER ircd

#ENTRYPOINT ["/usr/local/bin/charybdis", "-foreground", "-configfile", "/usr/local/etc/ircd.conf"]
ENTRYPOINT /usr/local/bin/charybdis-launcher.sh

