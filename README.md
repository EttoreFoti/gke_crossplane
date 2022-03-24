GKE Crossplane + Voting App Deployment
=======================================

This a Repository to bootstrap a GKE Cluster assuming we will use also a GKE instance for hosting Crossplane.

Requirements:
============
1) A Google Cloud Platform Account with: 
    - A project
    - A Service Account with: Kubernetes Engine Administrator, Compute Network Administrator and User Service Account
    - the service account .json key will be then asked in the scripts, it's also downloadable only on creation, so download it and keep it safe.
2) Google Cloud CLI 
3) A K8s cluster to install Crossplane on it we can create one on GKE or we can simply bootstrap a local cluster with kind or similar.

How to Use:
==========
- Complete the env_vars.sh template filling the right variables; do the same for crossplane/provider-config-gcp.template.yml. 
- Run 1-gcp_config.sh, and 2-install_crossplane.sh should be run on the K8s cluster we want to host our crossplane instance, it can be a GKE instance but can also be a simple Kind instance on our local machine.\
N.B. The first 1 scripts should be run only if we chose a GKE cluster to host our Crossplane instance.
- make sure to have the right context set for kubectl and run scripts/3-configure_gcp_provider.sh and scripts/4-create_gke_cluster.sh \
  At this point we should have created the cluster. We can check it through both kubectl (CLI) or GCP UI. 
- we deploy the kubernetes-provider just by applying its entire folder: \
$ kubectl apply -f crossplane_deploy_app/kubernetes_provider \
  N.B: we apply the definition to the Crossplane host that will then automatically take care of deploying them on the GKE Cluster we created. 
- we deploy the voting-sample-app just by applying its entire folder: \
  $ kubectl apply -f crossplane_deploy_app/vote_app_definition \
  N.B: we apply the definition in Step 4 and 5 to the Crossplane host that will then automatically take care of deploying them on the GKE Cluster we created.
- To make the web app reachable from our browser the last step is to create firewall rules for the nodePort exposed since GCP Firewall would block us: \
$ gcloud compute firewall-rules create test-app-node-port-31001 --allow tcp:31001 (do the same for both ports, the vote app and the result app, you use $ kubectl get svc -n vote to see the exposed ports; and kubectl get nodes -o wide to get the node IP)

References:
===========
* [Crossplane Official Docs](https://crossplane.io/docs/v1.7/)
* [Crossplane provider-gcp on Github](https://github.com/crossplane/provider-gcp)
* [Crossplane provider-kubernetes on Github](https://github.com/crossplane-contrib/provider-kubernetes)
* [K8s Voting App repo](https://github.com/dockersamples/example-voting-app)
* [Kind Kubernetes Official Website](https://kind.sigs.k8s.io)