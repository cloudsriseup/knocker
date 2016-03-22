#!/bin/bash

secretkey=$(cat secret)

totp=$(oathtool --totp -s 15 $secretkey)

ports=$(sed 's/./&00,/g; s/,$//' <<< $totp)



sed -i -r 's/^(\s*sequence\s*=).*$/\1 '"$ports"'/' /etc/knockd.conf

/etc/init.d/knockd restart
