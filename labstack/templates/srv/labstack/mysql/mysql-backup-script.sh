/usr/bin/mysqldump -u labstack_cron -pscale2Fast --all-databases | gzip > /srv/labstack/mysql/backup/database-archive_`date +'%Y-%m-%d'`.sql.gz