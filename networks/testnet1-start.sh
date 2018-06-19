#!/bin/sh
# testnet1 - fully connected validator testnet in AWS and full nodes in DO
# It will create 9 validators and 15 full nodes
# WARNING: Run it from the current directory - it uses relative paths to build and ship the binary
set -eux

# Build the linux binary we're going to ship to the nodes
make -C .. build-linux

# The testnet name is the same on all nodes
export TESTNET_NAME=testnet1

# Build the AWS validator nodes and extract the genesis.json and config.toml from one of them
SERVERS=3 REGION_LIMIT=1 CLUSTER_NAME=testnet1validatorsaws1 make validators-start-aws extract-config-aws

# Save the private key seed words from the validators
mkdir -p testnet1
test ! -d testnet1/validatorsaws1-seedwords && cp -r remote/ansible/keys "testnet1/validatorsaws1-seedwords"

# Build the DO full nodes using the extracted genesis.json and config.toml
SERVERS=15 CLUSTER_NAME=testnet1fullnodesdo1 make fullnodes-start-do

# Save the private key seed words from the full nodes
test ! -d testnet1/fullnodesdo1-seedwords && cp -r remote/ansible/keys "testnet1/fullnodesdo1-seedwords"

