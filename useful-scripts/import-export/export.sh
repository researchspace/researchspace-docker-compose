#!/bin/bash

# endpoint for export
sparqlEndpoint="http://localhost:10088/blazegraph/sparql"

graphsFile="graphs.tsv"

mkdir ./data

# get list of all named graphs
# in blazegraph default named graph is also included in the list of named graphs
# we are using tsv here instead of csv, because in csv serialization some values can be escaped https://www.w3.org/TR/sparql11-results-csv-tsv/#csv-terms where in tsv they stay as is
curl $sparqlEndpoint -H 'Accept:text/tab-separated-values' --data-urlencode 'query=SELECT DISTINCT ?g { GRAPH ?g { ?s ?p ?o } }' > $graphsFile

# go through the list of all named graph and export the content into ttl file
# we skip the first line of csv file because it has just binding name
i=0
while IFS=$'\n' read -r line; do
    graph=$(echo "$line" | tr -d '\n\r')
    curl $sparqlEndpoint -H 'Accept:application/n-triples' --data-urlencode "query=CONSTRUCT { ?s ?p ?o } WHERE { <http://www.bigdata.com/queryHints#Query> <http://www.bigdata.com/queryHints#analytic> "true" . <http://www.bigdata.com/queryHints#Query> <http://www.bigdata.com/queryHints#constructDistinctSPO> "false" . GRAPH $graph { ?s ?p ?o } }" -o "./data/$i.nt"
    (( i++ ))
done < <(tail -n +2 $graphsFile)

echo "Number of named graphs:"
curl $sparqlEndpoint -H 'Accept:text/csv' --data-urlencode "query=SELECT (COUNT(DISTINCT ?g) AS ?count) { GRAPH ?g { ?s ?p ?o . }}"

echo "Number of triples in named graphs:"
curl $sparqlEndpoint -H 'Accept:text/csv' --data-urlencode "query=SELECT (COUNT(*) AS ?count) { GRAPH ?g { ?s ?p ?o . }}"

echo "Number of triples in the null graph:"
curl $sparqlEndpoint -H 'Accept:text/csv' --data-urlencode "query=SELECT (COUNT(*) AS ?count) { GRAPH <http://www.bigdata.com/rdf#nullGraph> { ?s ?p ?o . }}"

