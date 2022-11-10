#!/bin/bash
docker build -t nikhilailani/byminni .
docker push nikhilailani/byminni

ssh deploy@$DEPLOY_SERVER << EOF
docker pull nikhilailani/byminni
docker stop api-boilerplate || true
docker rm api-boilerplate || true
docker rmi nikhilailani/byminni:current || true
docker tag nikhilailani/byminni:latest nikhilailani/byminni:current
docker run -d --restart always --name api-boilerplate -p 3000:3000 nikhilailani/byminni:current
EOF
