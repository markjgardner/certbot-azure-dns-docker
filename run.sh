#!/bin/bash
#Request a cert
certbot certonly \
    --authenticator dns-azure \
    --preferred-challenges dns \
    --noninteractive \
    --agree-tos \
    --email $EMAIL \
    --dns-azure-config /var/certbot/config/azure.ini \
    -d $DOMAIN 
#Make the keyvault secret name safe
SECRET_NAME=$(echo $DOMAIN | sed 's/\./-/g')
#Generate a password for the PFX file
PFX_PASSWORD=$(openssl rand -base64 32)
#Combine the cert and private key into a PKCS12 file
openssl pkcs12 \
    -export \
    -out /etc/letsencrypt/live/$DOMAIN/cert.pfx \
    -inkey /etc/letsencrypt/live/$DOMAIN/privkey.pem \
    -in /etc/letsencrypt/live/$DOMAIN/fullchain.pem \
    -password pass:$PFX_PASSWORD
#Save the cert to azure keyvault
az login --identity
az keyvault certificate import \
    --vault-name $KEYVAULT \
    --name $SECRET_NAME \
    --file /etc/letsencrypt/live/$DOMAIN/combined.pem \
    --password $PFX_PASSWORD 
