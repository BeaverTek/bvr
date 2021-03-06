#!/bin/sh

nginx

rsa_key_size=4096
certbot_path="/var/www/certbot"
lets_path="/etc/letsencrypt"

echo "Starting bootstrap"

if [ ! -e "${lets_path}/live//options-ssl-nginx.conf" ] \
    || [ ! -e "${lets_path}/live/ssl-dhparams.pem" ]; then

    echo "### Downloading recommended TLS parameters ..."
    mkdir -p "${lets_path}/live"

    curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > \
         "${lets_path}/options-ssl-nginx.conf"
    curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > \
         "${lets_path}/ssl-dhparams.pem"

    echo "### Creating dummy certificate for ${root_domain} ..."
    openssl req -x509 -nodes -newkey rsa:1024 -days 1\
            -keyout "${lets_path}/live/privkey.pem" \
            -out "${lets_path}/live/fullchain.pem" -subj '/CN=localhost'

    nginx -s reload

    rm -Rf "${lets_path}/live/${root_domain}"
    rm -Rf "${lets_path}/archive/${root_domain}"
    rm -Rf "${lets_path}/renewal/${root_domain}.conf"

    echo "### Requesting Let's Encrypt certificate for $root_domain ..."

    domain_args="-d ${root_domain}"
    for s in ${subdomains}; do
	domain_args="${domain_args} -d ${s}.${root_domain}"
    done

    # Select appropriate email arg
    case "$email" in
        "") email_arg="--register-unsafely-without-email" ;;
        *) email_arg="--email $email" ;;
    esac

    # Ask Let's Encrypt to create certificates, if challenge passed
    certbot certonly --webroot -w /var/www/certbot \
            $email_arg \
            $domain_args \
            --non-interactive \
            --rsa-key-size $rsa_key_size \
            --agree-tos \
            --force-renewal

else
    echo "Certificate related files exists, exiting"
fi
