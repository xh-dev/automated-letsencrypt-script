#!/bin/bash

source env.sh
letsencrypt_operation=$1

set | grep "letsencrypt_"

mkdir -p $letsencrypt_operation

run_certonly(){
	docker run --rm \
		-v "$letsencrypt_path:/etc/letsencrypt" \
		-p 80:80 \
		-it \
		certbot/certbot \
				$letsencrypt_operation \
				--standalone \
				--email $letsencrypt_email \
				--agree-tos \
				--preferred-challenges http \
				-d $letsencrypt_host \
				#--dry-run 
}

run_renew(){
	docker run --rm \
		-v "$letsencrypt_path:/etc/letsencrypt" \
		-p 80:80 \
		-it \
		certbot/certbot \
				$letsencrypt_operation \
				--standalone \
				--email $letsencrypt_email \
				--agree-tos \
				--preferred-challenges http \
				--dry-run 
}

case $letsencrypt_operation in 
	certonly)
		echo "Handle certonly"
		run_certonly
		echo "[Done]Handle certonly"
		exit 0
		;;
	renew)
		echo "Handle renew"
		run_renew
		echo "[Done]Handle renew"
		exit 0
		;;
	*)
		echo "no command match[certonly, renew]"
		exit 1
esac
