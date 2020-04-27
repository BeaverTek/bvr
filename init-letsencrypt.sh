#!/bin/bash

if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  exit 1
fi

domains=(hsal.es)
subdomains=(social wiki noise survey tube paste u matrix xmpp)
rsa_key_size=4096
data_path="./certbot"
email="hugo@fc.up.pt"

if [ -d "$data_path" ]; then
  read -p "Existing data found for $domains. \
Continue and replace existing certificate? (y/N) " decision
  if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
    exit
  fi
fi

# Disable https rewrite
sed -ri "s/(^\s+rewrite)/#\1/g" nginx.conf

if [ ! -e "$data_path/files/options-ssl-nginx.conf" ] \
    || [ ! -e "$data_path/files/ssl-dhparams.pem" ]; then
  echo "### Downloading recommended TLS parameters ..."
  mkdir -p "$data_path/files"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/\
       certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > \
       "$data_path/files/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/\
       certbot/certbot/ssl-dhparams.pem > \
       "$data_path/files/ssl-dhparams.pem"
  echo
fi

echo "### Creating dummy certificate for $domains ..."
path="/etc/letsencrypt/live/$domains"
mkdir -p "$data_path/files/live/$domains"
docker-compose run --rm --entrypoint "\
  openssl req -x509 -nodes -newkey rsa:1024 -days 1\
    -keyout '$path/privkey.pem' \
    -out '$path/fullchain.pem' \
    -subj '/CN=localhost'" certbot
echo


echo "### Starting nginx ..."
docker-compose up --force-recreate -d nginx
echo

echo "### Deleting dummy certificate for $domains ..."
docker-compose run --rm --entrypoint "\
  rm -Rf /etc/letsencrypt/live/$domains && \
  rm -Rf /etc/letsencrypt/archive/$domains && \
  rm -Rf /etc/letsencrypt/renewal/$domains.conf" certbot
echo


echo "### Requesting Let's Encrypt certificate for $domains ..."

# Format domain_args with the cartesian product of `domains` and `subdomains`
domain_args="-d "
for d in ${domains[@]}; do
    domain_args="$domain_args $d"
    for s in ${subdomains[@]}; do
	domain_args="${domain_args},$s.$d"
    done
done

# Select appropriate email arg
case "$email" in
  "") email_arg="--register-unsafely-without-email" ;;
  *) email_arg="--email $email" ;;
esac

# Ask Let's Encrypt to create certificates, if challenge passed
docker-compose run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    $email_arg \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --force-renewal" certbot
echo

# Reenable https rewrite
sed -ri "s/^#(\s+rewrite)/\1/g" nginx.conf

echo "### Reloading nginx ..."
docker-compose exec nginx nginx -s reload
