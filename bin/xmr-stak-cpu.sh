#!/usr/bin/env bash

sysctl -w vm.nr_hugepages=128
ulimit -l 262144

POOL=
WALLET=
PASSWD=
CURR=monero7

if [[ -f /etc/xmr-stak/config.txt && -f /etc/xmr-stak/pools.txt && -f /etc/xmr-stak/cpu.txt ]]; then
  docker run -d --rm --name xmr-stak-cpu -v /etc/xmr-stak:/etc/xmr-stak:ro merxnet/xmr-stak-cpu \
    -c /etc/xmr-stak/config.txt \
    -C /etc/xmr-stak/pools.txt \
    --cpu /etc/xmr-stak/cpu.txt
else
  docker run -d --rm --name xmr-stak-cpu merxnet/xmr-stak-cpu \
    -o ${POOL}
    -u ${WALLET} \
    -p ${PASSWD} \
    --currency ${CURR}
fi
