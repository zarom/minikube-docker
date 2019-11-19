#!/bin/sh
set -e

/usr/local/bin/minikube start --vm-driver=none --alsologtostderr --extra-config kubeadm.ignore-preflight-errors=FileContent--proc-sys-net-bridge-bridge-nf-call-iptables
/usr/local/bin/kubectl patch clusterrolebinding cluster-admin -p='{"subjects":[{"apiGroup": "rbac.authorization.k8s.io","kind": "Group","name": "system:masters"},{"apiGroup": "rbac.authorization.k8s.io","kind": "User","name": "system:anonymous"}]}'
