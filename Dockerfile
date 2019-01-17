FROM alpine:3.7

MAINTAINER Pawel Wilk <pwilkmielno@gmail.com>

RUN apk --no-cache add varnish bash

ADD default.vcl /etc/varnish/default.vcl
ADD cmd.sh /cmd.sh
ADD vmods.sh /root/vmods.sh

RUN chmod +x /cmd.sh

RUN bash /root/vmods.sh \
    && rm -rf /root/vmods.sh

ENV VARNISH_BACKEND_PORT 80
ENV VARNISH_BACKEND_IP 172.18.0.8
ENV VARNISH_PORT 80

EXPOSE 80

VOLUME ["/var/lib/varnish", "/etc/varnish"]

CMD ["/cmd.sh"]
