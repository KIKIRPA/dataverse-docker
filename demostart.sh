#!/bin/bash

if [ ! -f ".env" ]; then
  cp .env_sample .env
fi
docker-compose up -d
