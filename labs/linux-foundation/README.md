# Linux Foundation Lab

## Purpose

This lab demonstrates Linux administration and troubleshooting skills relevant to the ResilientOps AWS Platform:

- Filesystem navigation and application directories
- Users, groups, ownership and permissions
- Least-privilege service execution
- Processes and listening ports
- HTTP health checks
- Logs and outage investigation
- Container networking, routing and DNS

No AWS resources were created.

## Environment

| Component | Value |
|---|---|
| Host | macOS on Apple Silicon |
| Virtualisation | Colima |
| Container runtime | Docker |
| Linux distribution | Ubuntu 24.04.5 LTS |
| Architecture | ARM64 / `aarch64` |
| Application port | TCP/8080 |

## Start the environment

```bash
colima start --cpu 2 --memory 2 --disk 10

docker run --name resilientops-linux-lab \
  --hostname resilientops-lab \
  -it ubuntu:24.04 bash
```

To reconnect to the stopped lab:

```bash
docker start -ai resilientops-linux-lab
```

## Application filesystem

The following structure was created:

```text
/opt/resilientops
├── app
│   └── service.py
├── config
│   └── app.conf
└── logs
    ├── app.log
    ├── http.log
    └── http.pid
```

Configuration:

```text
APP_PORT=8080
APP_ENV=learning
```

## Least-privilege service account

A non-interactive system account was created:

```bash
groupadd --system resilientops

useradd --system \
  --gid resilientops \
  --home-dir /opt/resilientops \
  --shell /usr/sbin/nologin \
  resilientops
```

Application code and configuration remained owned by `root`, while the service account received only the access it required:

```bash
chown -R root:resilientops app config
chmod 750 app config
chmod 640 app/service.py config/app.conf

chown -R resilientops:resilientops logs
chmod 750 logs
chmod 640 logs/app.log
```

The service account could read the configuration and write logs, but an attempt to modify `config/app.conf` returned:

```text
Permission denied
```

This verified that the least-privilege permissions worked.

## Process and port verification

A temporary training service was started as the restricted account:

```bash
runuser -u resilientops -- sh -c \
  'nohup python3 -m http.server 8080 --directory /opt/resilientops/app > /opt/resilientops/logs/http.log 2>&1 & echo $! > /opt/resilientops/logs/http.pid'
```

The service was inspected using:

```bash
ps -o pid,ppid,user,stat,cmd \
  -p "$(cat logs/http.pid)"

ss -lntp | grep ':8080'

curl -I http://127.0.0.1:8080
```

Verified results:

- The Python process ran as `resilientops`, not `root`.
- TCP/8080 entered the `LISTEN` state.
- The HTTP health request returned `200 OK`.
- The request was recorded in `http.log`.

The Python file server is for training only and is not intended to represent a production application.

## Container networking

Observed network information:

| Item | Observed value |
|---|---|
| Hostname | `resilientops-lab` |
| Container address | `172.17.0.2/16` |
| Docker gateway | `172.17.0.1` |
| Network interface | `eth0` |
| DNS resolution | Successful |

Commands used:

```bash
hostname
hostname -I
ip -brief address
ip route
cat /etc/resolv.conf
dig +short example.com
```

The container was created without a published host port. Listening on `0.0.0.0:8080` therefore made the application available on the container interfaces but did not expose it directly through the Mac.

## Outage simulation

The process was deliberately stopped:

```bash
kill "$(cat logs/http.pid)"
```

The following troubleshooting sequence was used:

```bash
ps -p "$(cat logs/http.pid)"
ss -lnt | grep ':8080'
curl --max-time 2 -I http://127.0.0.1:8080
tail -n 5 logs/http.log
```

Observed results:

- The application process was absent.
- Port 8080 was no longer listening.
- The HTTP health check failed.
- The log retained evidence of the earlier successful request.

## Recovery and readiness

The service was restarted using the restricted account. An immediate health check initially failed, but the process was still running. After a short startup period:

- The process remained healthy.
- Port 8080 returned to the `LISTEN` state.
- The health check returned `200 OK`.

This demonstrated that a running process is not necessarily ready to receive traffic immediately. Production health checks require a startup grace period or retry policy.

## Troubleshooting workflow

The evidence-based sequence used in this lab was:

1. Check whether the process exists.
2. Check whether the expected port is listening.
3. Test the application endpoint.
4. Inspect logs for evidence.
5. Restart the application.
6. Allow a startup period.
7. Repeat the health check.

## Relationship to the AWS design

The Linux application port matches the Terraform application security-group rule:

```text
Internet → ALB on HTTPS/443
ALB → application on TCP/8080
Internet → application directly denied
```

Linux permissions protect the process and local files. AWS security groups protect the network path to the process. Both layers are required.

## Current limitation and next step

`service.py` is currently a placeholder, and the lab used Python’s temporary HTTP file server.

The next milestone will replace it with a minimal application providing:

- `/`
- `/health`
- `/version`
- Environment-based configuration
- Automated tests
- Non-root Docker execution
- A repeatable container health check

## Stop the environment

Exit the container:

```bash
exit
```

Stop Colima when it is no longer required:

```bash
colima stop
```