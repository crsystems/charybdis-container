#!/bin/bash
# 
# Launcher for the Charybdis docker container.
# Checks for the pid file of a previous, not well terminated instance, and deletes it.
# After that charybdis is launched.

if [ -f /usr/local/etc/ircd.pid ]; then
	echo "Deleting old PID file";
	rm /usr/local/etc/ircd.pid;
fi

/usr/local/bin/charybdis -foreground -configfile /usr/local/etc/ircd.conf

