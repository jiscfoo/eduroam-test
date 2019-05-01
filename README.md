Compliance check tool for eduroam
=================================

This toolset uses `nmap` and either [Vagrant](https://www.vagrantup.com/) or [Docker](https://www.docker.com/) to check a local network's compliance with the [eduroam(UK) Technical Specification](https://community.jisc.ac.uk/groups/eduroam/document/eduroamuk-technical-specification-v14).

It is intended as for system and network administrators to verify their local firewall configuration by making connections and sending packets to a Jisc hosted endpoint.

Caveats
-------

 1. Some firewalls do not some UDP packets which are _invalid_ for the port being tested's protocol (mainly this is IPSEC on `udp/500`).
 2. The endpoint currently only supports the TCP or UDP protocol checks, not the other IP protocols.

Running
-------

Three options are available, depending on the local toolset available:

 1. Vagrant and a local hypervisor (eg. [Virtualbox](https://www.virtualbox.org/))
 2. Docker
 3. A downloadable _appliance_ to run within a local hypervisor (coming..?)

All three end up running the supplied `eduroam-test.sh` shell script.

### Vagrant

First validate the `Vagrantfile` and `eduroam-test.sh` script to ensure you're happy with what it will do.

#### Initial setup

```
vagrant up
vagrant upload eduroam-test.sh
```

#### Running the checks

```
vagrant ssh -- sudo bash eduroam-test.sh
```

#### Tidy up

When you're finished testing, you'll need to tidy up:

```
vagrant halt 
vagrant destroy -f
```

### Docker

First validate the `Dockerfile` and `eduroam-test.sh` script to ensure you're happy with what it will do.

#### Initial setup

```
docker build -t jisc/eduroam-test .
```

#### Running the checks

```
docker run --rm -i jisc/eduroam-test
```

#### Tidy up

When you're finished testing, you'll need to tidy up:

```
docker rmi jisc/eduroam-test
docker rmi base/archlinux     # optional
```

### VirtualBox Appliance

This is a virtual appliance based on Alpine Linux with the required utilities pre-installed.

#### Initial setup

In the VirtualBox manager, _Import_ the `.ova` file and follow the wizard.

#### Running the checks

 1. Start the VM and wait for it to boot
 2. Log in as root with no password
 3. Run `bash eduroam-test/eduroam-test.sh`
 4. When finished, run `poweroff`

#### Tidy up

Delete the VM (and remove all files) from the manager

Output
------

You should see an output from the `nmap` command similar to that below. Ideally, all of the STATE results should be `open`.

```
Starting Nmap 7.70 ( https://nmap.org ) at 2019-01-02 12:36 UTC
Nmap scan report for eduroamuk-probe.dev.ja.net (193.63.63.194)
Host is up, received user-set (0.029s latency).

PORT      STATE         SERVICE          REASON
21/tcp    open          ftp              syn-ack
22/tcp    open          ssh              syn-ack
80/tcp    open          http             syn-ack
143/tcp   open          imap             syn-ack
220/tcp   open          imap3            syn-ack
406/tcp   open          imsp             syn-ack
443/tcp   open          https            syn-ack
465/tcp   open          smtps            syn-ack
587/tcp   open          submission       syn-ack
636/tcp   open          ldapssl          syn-ack
993/tcp   open          imaps            syn-ack
995/tcp   open          pop3s            syn-ack
1194/tcp  open          openvpn          syn-ack
1494/tcp  open          citrix-ica       syn-ack
3128/tcp  open          squid-http       syn-ack
3389/tcp  open          ms-wbt-server    syn-ack
3653/tcp  open          tsp              syn-ack
5900/tcp  open          vnc              syn-ack
8080/tcp  open          http-proxy       syn-ack
10000/tcp open          snet-sensor-mgmt syn-ack
123/udp   filtered      ntp              host-prohibited ttl 52
500/udp   open|filtered isakmp           no-response
1194/udp  open          openvpn          udp-response ttl 64
3653/udp  open          tsp              udp-response ttl 64
4500/udp  open          nat-t-ike        udp-response ttl 64
7000/udp  open          afs3-fileserver  udp-response ttl 64
7001/udp  open          afs3-callback    udp-response ttl 64
7002/udp  open          afs3-prserver    udp-response ttl 64
7003/udp  open          afs3-vlserver    udp-response ttl 64
7004/udp  open          afs3-kaserver    udp-response ttl 64
7005/udp  open          afs3-volser      udp-response ttl 64
7006/udp  open          afs3-errors      udp-response ttl 64
7007/udp  open          afs3-bos         udp-response ttl 64
10000/udp open          ndmp             udp-response ttl 64

Nmap done: 1 IP address (1 host up) scanned in 15.79 seconds
```