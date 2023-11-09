# Datadog Installation on K8s cluster with tainted nodes

Steps that were run to put Datadog on all nodes

## Steps

Run a script to show the nodes in the given namespace that don't have datadog agent

```
bash-3.2$ ./nodes-without-datadog.sh iam-authn-psr-as-int-1
> "kc-d-identity-2-openam-2-zone-01-worker10"
> "kc-d-identity-2-openam-2-zone-01-worker13"
> "kc-d-identity-2-openam-2-zone-01-worker4"
> "kc-d-identity-2-openam-2-zone-02-worker2"
> "kc-d-identity-2-openam-2-zone-02-worker6"
> "kc-d-identity-2-openam-2-zone-02-worker9"
> "kc-d-identity-2-openam-2-zone-03-worker1"
> "kc-d-identity-2-openam-2-zone-03-worker10"
> "kc-d-identity-2-openam-2-zone-03-worker7"
```
export DD_API_KEY=''
export DD_APP_KEY=''

kubectl config set-context --current --namespace=datadog

kubectl create secret generic datadog-secret --from-literal api-key=$DD_API_KEY --from-literal app-key=$DD_APP_KEY

helm install --namespace datadog -f ./identity-values-toleration.yaml datadog datadog/datadog

Verify all nodes now have datadog agent
```
bash-3.2$  ./nodes-without-datadog.sh iam-authn-psr-as-int-1   
<no output>
```
