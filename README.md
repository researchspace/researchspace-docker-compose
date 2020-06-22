Collection of sample docker-compose scripts that can be used to setup ResearchSpace.

## Prerequisites

* We recommend to use docker based setup only on Linux. If you want to run ResearchSpace on MacOS or Windows, please use zip-based distribution.

As a baseline we use docker and docker-compose that are used in the latest Ubuntu 20.04 LTS:
* docker >= 19.03.8
* docker-compose >= 1.25


If you are using `Ubuntu 20.04 LTS` then you can install docker with a single command:
```
sudo -- sh -c 'apt update && apt install docker.io docker-compose -y'
```

##  

* [basic](./basic) - ResearchSpace with blazegraph and digilib, good for local testing
* [full-setup-with-letsencrypt](./full-setup-with-letsencrypt) - ResearchSpace with blazegraph, digilib, and nginx with letsencrypt
