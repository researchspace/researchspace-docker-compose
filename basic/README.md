# ResearchSpace with blazegraph and digilib

## Setup

Set `COMPOSE_PROJECT_NAME` in the *.env* file.

If using UBUNTU, run the following two commands; Not necessary for OS X setups.
```
chmod +x ./fix-folder-permissions.sh
./fix-folder-permissions.sh
```

Start the service stack
```
docker-compose up -d
```

Check in the terminal if any issues appeared initiating the docker containers:  
```
docker ps -a 
docker logs <yourdockercontainerid>
```

Go to your browser (Chrome, Firefox) and login with admin/admin at:
```
http://localhost:10214
```

## Configuration
The previous steps allowed you to setup an empty instance of ResearchSpace with a basic service stack: platform, blazegraph, and digilib.

To use this instance with CIDOC-CRM v6.2.1, CRMarcheo v1.4.1, CRMba v1.4, CRMdig v3.2.1, CRMgeo v1.2, CRMinf v0.7, CRMsci, and FRBRoo download example configurations from https://github.com/researchspace/researchspace-instance-configurations  and import them in your empty instance of ResearchSpace. 
