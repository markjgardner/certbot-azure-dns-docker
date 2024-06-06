# certbot + dns-azure -> docker
This repo produces a docker container with [certbot](certbot/certbot) and the [azure dns validator](terricain/certbot-dns-azure) included. The goal is to have a simple image that can be used for automating the provisioning of a cert for an apex domain hosted via Azure CDN (not supported natively).

## Running the image on azure
The bicep file in [deploy](/deploy/main.bicep) will run this container as an Azure Container Apps job that runs once per month. It will save the provisioned cert to a key vault for consumption by your preferred CDN/edge network.