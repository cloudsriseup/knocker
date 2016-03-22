#!/bin/bash

server=$1
secret=$(openssl enc -aes-256-cbc -d -a -in secret.enc)
totp=$(oathtool --totp -s 15 $secret)
ports=$(sed 's/./&00 /g; s/ $//' <<< $totp)

for ipv6port in $ports; do
    knock "$server" "$ipv6port"
done
