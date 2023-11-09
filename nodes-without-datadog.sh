# nodes-without-datadog.sh - for a given namespace, prints out the nodes that don't have datadog
#!/bin/bash

# Check if the namespace is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

# Get list of datadog nodes
kubectl get pods -n datadog -o json | jq '.items[].spec.nodeName' | sort -u > datadog-nodes.out

# Assign the provided namespace to a variable
namespace="$1"

# Get a unique list of nodes for the specified namespace
kubectl get pods -n "$namespace" -o json | jq '.items[].spec.nodeName' | sort -u > $namespace"-nodes.out"

# Get nodes without datadog
diff datadog-nodes.out $namespace"-nodes.out" | grep '>'
