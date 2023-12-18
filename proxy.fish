#!/bin/fish
set hostip (cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
set wslip (hostname -I | awk '{print $1}')

# Complete with your port
set port __YOUR_PORT

# Complete with your proxy settings
set PROXY_HTTP "http://@$hostip:$port"
# set PROXY_HTTP "http://user:password@$hostip:$port"

function set_proxy
	echo wsl ip: $wslip, hostip: $hostip
	set -Ux ALL_PROXY $PROXY_HTTP
	set -Ux FTP_PROXY $PROXY_HTTP
	set -Ux HTTPS_PROXY $PROXY_HTTP
	set -Ux HTTP_PROXY $PROXY_HTTP
	set -Ux all_proxy $PROXY_HTTP
	set -Ux ftp_proxy $PROXY_HTTP
	set -Ux http_proxy $PROXY_HTTP
	set -Ux https_proxy $PROXY_HTTP
end

function unset_proxy
	set -e ALL_PROXY 
	set -e FTP_PROXY
	set -e HTTPS_PROXY
	set -e HTTP_PROXY
	set -e all_proxy
	set -e ftp_proxy
	set -e http_proxy
	set -e https_proxy
end

if test -z "$argv[1]"
	echo "No Argument."
	exit 1
end
switch $argv[1]
	case set
		set_proxy
	case unset
		unset_proxy
	case '*'
		echo "Wrong Argument"
		exit 1
end
