# ResearchSpace Migration Notes

The current version of RS requires a few ammendments at data level and also in the configuration of services connected to RS.

## Updating users IRIs 
```
PREFIX prov: <http://www.w3.org/ns/prov#>
DELETE {
  GRAPH ?g {
    ?s prov:wasAttributedTo ?user .
  }
} INSERT {
  GRAPH ?g {
    ?s prov:wasAttributedTo ?newUser .
  }
} WHERE {
  GRAPH ?g {
    ?s prov:wasAttributedTo ?user .
  }
  BIND(IRI(REPLACE(STR(?user), "http://www.metaphacts.com/resource/user/", "http://www.researchspace.org/resource/user/")) AS ?newUser) 
}
```

## Updating your LDAP connection

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