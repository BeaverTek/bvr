#!/bin/sh

root="/etc/certs/live/$(echo "$MAILNAME" | sed -r "s/[^\.]+\.//")"

cp "$(readlink -f "$root"/privkey.pem)" /etc/ssl/exim.key
cp "$(readlink -f "$root"/fullchain.pem)" /etc/ssl/exim.crt

chown exim:exim /etc/ssl/exim.key
chown exim:exim /etc/ssl/exim.crt

echo "$MAILNAME" > /etc/mailname

sed -ri "s/%hostname%/${MAILNAME}/" /etc/exim/exim.conf

exec "$@"
