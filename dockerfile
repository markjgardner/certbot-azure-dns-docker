FROM certbot/certbot
RUN pip3 install certbot certbot-dns-azure
ENV DOMAIN=example.com
ENV EMAIL=admin@example.com
VOLUME /var/certbot/config/
VOLUME /var/certbot/certs/
ENTRYPOINT certbot certonly --authenticator dns-azure --preferred-challenges dns --noninteractive --agree-tos --email $EMAIL --dns-azure-config /var/certbot/config/azure.ini -d $DOMAIN --cert-path /var/certbot/certs/$DOMAIN.cert