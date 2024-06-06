FROM certbot/certbot
RUN apk add gcc python3-dev musl-dev linux-headers
RUN pip3 install certbot certbot-dns-azure azure-cli
ENV DOMAIN=example.com
ENV EMAIL=admin@example.com
ENV KEYVAULT=example-keyvault
COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh
ENTRYPOINT [ "/bin/sh", "/root/run.sh" ]
