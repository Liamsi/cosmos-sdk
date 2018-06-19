#!/bin/sh
# shut down testnet1 
# WARNING: Run it from the current directory - it uses relative paths
set -eux

export TESTNET_NAME=testnet1

CLUSTER_NAME=testnet1validatorsaws1 make validators-stop-aws
CLUSTER_NAME=testnet1fullnodesdo1 make fullnodes-stop-do

