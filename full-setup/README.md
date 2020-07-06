# ResearchSpace with blazegraph, digilib, nginx and SSL certificates from LetsEncrypt

## Prerequisites
* valid domain name with properly set DNS record

## Setup

Set  `RESEARCHSPACE_HOST_NAME`, `COMPOSE_PROJECT_NAME` in the *.env* file.

```
chmod +x ./fix-folder-permissions.sh
./fix-folder-permissions.sh
docker-compose up -d
```
Check in the terminal if any issues appeared initiating the docker containers:  
```
docker ps -a 
docker logs <yourdockercontainerid>
```

Go to your browser (Chrome, Firefox) and login with *admin/admin* at:
```
http://localhost:10214
```

## Configuration
The previous steps allowed you to setup an empty instance of ResearchSpace with a basic service stack: platform, blazegraph, and digilib.

To use this instance with CIDOC-CRM v6.2.1, CRMarcheo v1.4.1, CRMba v1.4, CRMdig v3.2.1, CRMgeo v1.2, CRMinf v0.7, CRMsci, and FRBRoo download example configurations from https://github.com/researchspace/researchspace-instance-configurations  and import them in your empty instance of ResearchSpace. 

## A running ResearchSpace instance 
```
-rw-rw-r-- 1 deploy deploy 1537 Jun 24 09:58 .env
-rw-rw-r-- 1 deploy deploy  334 Jun 24 08:12 README.md
drwxr-xr-x 2    999 nobody 4096 Jun 24 08:30 blazegraph
-rw-rw-r-- 1 deploy deploy 4464 Jun 24 08:40 docker-compose.yml
-rwxrwxr-x 1 deploy deploy  949 Jun 24 08:12 fix-folder-permissions.sh
drwxrwxr-x 6 deploy deploy 4096 Jun 24 08:30 nginx
drwxrwsr-x 4 syslog root   4096 Jun 24 08:30 researchspace
```
After starting a RS instance two new folders are created: *blazegraph* and *nginx*. Within this configuration:

* Data is saved by default in the *blazegraph/blazegraph.jnl* file, if a different location for the journal file is required edit the *docker-compose.yml*
* Nginx configurations and files are stored in the *nginx* folder
* Images, files, and other configurations are stored under the *researchspace* folder, see the recursive listing below of the folder content.

Note, further configurations can be added to the *runtime-data/config*, followed by a docker restart of the platform container.
```
.:
data  runtime-data

./data:
images

./data/images:
file

./data/images/file:

./runtime-data:
config  data

./runtime-data/config:
shiro-ldap.ini  shiro.ini

./runtime-data/data:
repositories

./runtime-data/data/repositories:
tests

./runtime-data/data/repositories/tests:
contexts.dat  namespaces.dat  triples-posc.alloc  triples-spoc.alloc  triples.prop  values.dat   values.id
lock          nativerdf.ver   triples-posc.dat    triples-spoc.dat    txn-status    values.hash

./runtime-data/data/repositories/tests/lock:
locked  process
```


## Configuration with git storage for a custom-app
Edit *.env* file to link to your git repository (replace *yourgitrepositorylocation.git* with the appropriate path)
```
RESEARCHSPACE_OPTS=-Dorg.eclipse.jetty.server.Request.maxFormContentSize=9000000 -Dconfig.storage.runtime.type=git -Dconfig.storage.runtime.mutable=true -Dconfig.storage.runtime.localPath=/custom-app -Dconfig.storage.runtime.branch=yourbranchname -Dconfig.storage.runtime.remoteUrl=ssh://*yourgitrepositorylocation.git*
```
Edit *docker-compose.yml* to specify location of your custom-app

For the *researchspace* service under *volumes* add the corresponding paths to the rsa keys that enable sign in to the git storage where your custom-app is located
```
# permission for git to commit to stash.researchspace.org
- /home/<youruser>/.ssh:/home/jetty/.ssh
- /home/<youruser>/custom-app:/custom-app
```

## How to integrate this service stack with:

### An independent nginx reverse proxy 

To prevent any issues please make sure that in your configuration file corresponding to the RS intance you are trying to setup you do not use https, instead https it is used until the reverse proxy is reached. Also, the following directive if it exists in your configuration needs to be removed:
```
proxy_set_header X-Forwarded-Proto $scheme;
```

### LDAP 
Create file shiro-ldap.ini in *researchspace/runtime-data/config*
```
[main]
ldapRealm = org.researchspace.security.LDAPRealm
ldapRealm.groupMemberAttribute = member
ldapRealm.groupIdentifierAttribute=cn
ldapRealm.searchBase = dc=researchspace,dc=org
ldapRealm.userIdentifierAttribute=uid
ldapRealm.userObjectClass=person
ldapRealm.contextFactory.url = ldap://yourldapserver:389
ldapRealm.contextFactory.systemUsername = uid=readOnly,ou=System,dc=researchspace,dc=org
ldapRealm.contextFactory.systemPassword = yourldappassword
ldapRealm.groupRolesMap = "cn=repository-admin,ou=platform,ou=yourresearchspaceinstance,ou=deployments,dc=researchspace,dc=org":"repository-admin","cn=admin,ou=platform,ou=yourresearchspaceinstance,ou=deployments,dc=researchspace,dc=org":"admin", "cn=root,ou=platform,ou=yourresearchspaceinstance,ou=deployments,dc=researchspace,dc=org":"root", "cn=query-catalog,ou=platform,ou=yourresearchspaceinstance,ou=deployments,dc=researchspace,dc=org":"query-catalog", "cn=repository-admin,ou=platform,ou=yourresearchspaceinstance,ou=deployments,dc=researchspace,dc=org":"repository-admin","cn=guest,ou=platform,ou=yourresearchspaceinstance,ou=deployments,dc=researchspace,dc=org":"guest"
securityManager.realms = $ldapRealm
```