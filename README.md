# certbot + dns-azure -> docker
This repo produces a docker container with [certbot](certbot/certbot) and the [azure dns validator](terricain/certbot-dns-azure) included. The goal is to have a simple image that can be used for automating the provisioning of a cert for an apex domain hosted via Azure CDN (not supported natively).

## Running the image on azure
docker run -it --rm -e "DOMAIN=example.com" -e "EMAIL=admin@example.com" -v /workspaces/certbot-azure-dns-docker/example:/var/certbot/config ghcr.io/markjgardner/certbot-dns-azure