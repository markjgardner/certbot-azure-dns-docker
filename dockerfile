FROM certbot/certbot
RUN apk add gcc python3-dev musl-dev linux-headers
RUN pip3 install certbot certbot-dns-azure azure-cli
ENV DOMAIN=example.com
ENV EMAIL=admin@example.com
ENV KEYVAULT=example-keyvault
VOLUME /var/certbot/config
COPY --chmod=755 run.sh /root/run.sh
ENTRYPOINT [ "/bin/sh", "/root/run.sh" ]
