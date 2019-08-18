FROM alpine

LABEL maintainer="wangjun <traceflight@outlook.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV FRP_VERSION 0.28.2
ENV FRP_DOWNLOAD_URL https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz
RUN apk upgrade --update \
    && apk add bash tzdata curl \
    && curl -sSLO ${FRP_DOWNLOAD_URL} \
    && tar -zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && mkdir /etc/frp \
    && mv frp_${FRP_VERSION}_linux_amd64/frps.ini /etc/frp \
    && mv frp_${FRP_VERSION}_linux_amd64/frps /usr/bin \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && apk del curl \
    && rm -rf frp_${FRP_VERSION}_linux_amd64.tar.gz \
        frp_${FRP_VERSION}_linux_amd64 \
        /var/cache/apk/*

CMD ["frps","-c","/etc/frp/frps.ini"]
