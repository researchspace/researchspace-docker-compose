#!/bin/bash

# endpoint for import
sparqlEndpoint="http://localhost:10214/blazegraph/sparql"

graphsFile="graphs.tsv"

i=0
while IFS= read -r line; do
    graph=$(echo "$line" | tr -d '\n\r')
    curl $sparqlEndpoint --data-urlencode "update=LOAD <file:$(pwd)/data/$i.nt> INTO GRAPH $graph"
    (( i++ ))
done < <(tail -n +2 $graphsFile)

echo "Number of named graphs:"
curl $sparqlEndpoint -H 'Accept:text/csv' --data-urlencode "query=SELECT (COUNT(DISTINCT ?g) AS ?count) { GRAPH ?g { ?s ?p ?o . }}"

echo "Number of triples in named graphs:"
curl $sparqlEndpoint -H 'Accept:text/csv' --data-urlencode "query=SELECT (COUNT(*) AS ?count) { GRAPH ?g { ?s ?p ?o . }}"

echo "Number of triples in the null graph:"
curl $sparqlEndpoint -H 'Accept:text/csv' --data-urlencode "query=SELECT (COUNT(*) AS ?count) { GRAPH <http://www.bigdata.com/rdf#nullGraph> { ?s ?p ?o . }}"

