#!/bin/bash



caddy fmt --overwrite 
caddy start Caddyfile 
bun server.js  



