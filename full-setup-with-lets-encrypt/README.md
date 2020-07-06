# ResearchSpace with blazegraph, digilib, nginx and SSL certificates from LetsEncrypt

## Prerequisites

* valid domain name with properly set DNS record

## Setup

Set `RESEARCHSPACE_HOST_NAME`, `COMPOSE_PROJECT_NAME` and `LETSENCRYPT_EMAIL` in the *.env* file.

```
chmod +x ./fix-folder-permissions.sh
./fix-folder-permissions.sh
docker-compose up -d
```
