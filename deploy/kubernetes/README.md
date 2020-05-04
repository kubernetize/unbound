# Kubernetes deployment

The deployment is configured to run the pods with hostnetwork. This means, you should label your nodes
where you want to run unbound with `dns=unbound`, and then deploy with the correct number of replicas.
