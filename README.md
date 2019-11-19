# Minikube image

Image possible to run minikube instance inside docker container. 
Good for integration testing, for example, with Java testcontainers.

## How to run

Minikube needs systemd, cgroups and privileged container to work.

```docker run --rm --privileged -d -p8443:8443 -v /sys/fs/cgroup:/sys/fs/cgroup:ro zarrom/minikube```

Minikube needs about 1 minute to startup. You can check healthy status in *STATUS* field of `docker ps`. Example of succefully started minikube container:
```

CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS                        PORTS                    NAMES
eabfdf56c456        minikube            "/bin/sh -c /usr/sbi  "   About a minute ago   Up About a minute (healthy)   0.0.0.0:8443->8443/tcp   upbeat_vaughan
```

Kubeapi anonymously exposed on port 8443.
```
curl -k  https://localhost:8443/api
{
  "kind": "APIVersions",
  "versions": [
    "v1"
  ],
  "serverAddressByClientCIDRs": [
    {
      "clientCIDR": "0.0.0.0/0",
      "serverAddress": "192.168.50.1:8443"
    }
  ]
}
```
