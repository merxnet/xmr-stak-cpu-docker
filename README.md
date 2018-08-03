# Dockerized XMR-Stak (CPU) Monero miner

[![GitHub Release](https://img.shields.io/github/release/merxnet/xmr-stak-cpu-docker/all.svg)](https://github.com/merxnet/xmr-stak-cpu-docker/releases)
[![GitHub Release Date](https://img.shields.io/github/release-date-pre/merxnet/xmr-stak-cpu-docker.svg)](https://github.com/merxnet/xmr-stak-cpu-docker/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/merxnet/xmr-stak-cpu.svg)](https://hub.docker.com/r/merxnet/xmr-stak-cpu/)

The goal for this code is to create a modular and easy-to-use Docker image of the popular XMR-Stak (CPU) Monero miner. Discover and support the source code [here](https://github.com/fireice-uk/xmr-stak). There are also code repositories for "Dockerized" versions of the [NVIDIA GPU](https://github.com/merxnet/xmr-stak-nvidia-docker) and [AMD GPU](https://github.com/merxnet/xmr-stak-amd-docker) miners as well. Note that XMR-Stak offers a unified miner which supports CPUs and AMD/NVIDIA GPUs; however, for simplicity each image contains source code compiled for a single purpose.

## Quickstart
The Docker image created by this code is conveniently available on [Docker Hub](https://hub.docker.com/r/merxnet/xmr-stak-cpu/).
```
docker pull merxnet/xmr-stak-cpu
```
To get started, all you need is a [wallet](https://getmonero.org/resources/user-guides/create_wallet.html) and a [mining pool](https://monero.org/services/mining-pools/) of your choice, such as [MoriaXMR](https://moriaxmr.com/). You may also be prompted for a password, which in this case is simply an identifer for the host. This information can be provided on the command line at run time:
```
docker run merxnet/xmr-stak-cpu -o ${POOL} -u ${WALLET} -p ${HOST}:${HOST} --currency monero7
```
To get the most out of mining, be sure to check out the sections below as well as the documentation at the [source code's GitHub page](https://github.com/fireice-uk/xmr-stak/blob/master/doc/usage.md).

## Usage
This Docker image can be treated just like the binary -- that is, you can provide any and all command line options directly. For example:
```
docker run -d --name xmr-stak-cpu merxnet/xmr-stak-cpu \
  -O us.moriaxmr.com:9000 \
  -u ${WALLET} \
  -p ${PASSWD} \
  --currency monero7
```
Most often it is easiest to provide configuration files. To do this, it is recommended that all configuration files be stored in the same directory on the host and then passed to the container at runtime:
```
docker run -d -v /etc/xmr-stak:/etc/xmr-stak:ro merxnet/xmr-stak-cpu \
  -c /etc/xmr-stak/config.txt \
  -C /etc/xmr-stak/pools.txt \
  --cpu /etc/xmr-stak/cpu.txt
```
To see examples and benchmarks, visit the [XMR-Stak website](https://www.xmrstak.com/).

## Host Configuration
For CPU mining, minimal configuration is required for the host machine (i.e., the machine running `dockerd`). To get the most out of each CPU, it is recommended that you enable [hugepages](https://wiki.debian.org/Hugepages) if possible. On most Linux distributions, it's a single command:
```
sysctl -w vm.nr_hugepages=128
```
This, however, is not permanent between reboots. Instead, you can create a `.conf` file in `/etc/sysctl.d/` to ensure hugepages is enabled on every boot. See more information about `sysctl` [here](https://wiki.archlinux.org/index.php/Sysctl).

## Support
Feel free to fork and create pull requests or create issues. Feedback is always welcomed. One can also send donatations to the Monero wallet below.
```
43txUsLN5h3LUKpQFGsFsnRLCpCW7BvT2ZKacsfuqYpUAvt6Po8HseJPwY9ubwXVjySe5SmxVstLfcV8hM8tHg8UTVB14Tk
```
Thank you.
