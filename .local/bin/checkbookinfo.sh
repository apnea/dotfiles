#!/bin/bash
while true; do curl -s -o /dev/null -w "%{http_code}" https://api.bookinfo.club/bulk | grep -q "521" && echo "Website is down (Cloudflare 521 error)" || echo "Website is up"; sleep 1m; done
