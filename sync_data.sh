#!/bin/sh
# Synchronizace tmp systemu s SD kartou
rsync -a /var/www/html/* /root/backup_data/
