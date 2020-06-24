Can be used to export/import all named graphs and default graph into/from blazegraph instance.

* Edit `sparqlEndpoint` variable to point to blazegraph sparql endpoint.
* Export assumes that blazegraph has access to the actual files with data, because we use `LOAD <file:/> ...` command
