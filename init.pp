class drupal {
exec {'apt-get update':
path => '/usr/bin',
}
package {'apache2':
ensure => present,
}
service {'apache2':
ensure => running,
}
package {'mysql-server':
ensure => present,
}
service {'mysql':
ensure => running,
}
package{'php5':
ensure => present,
require => Service['apache2'],
}
file {'/var/www/html/info.php':
ensure => present,
content => '<?php phpinfo(); ?>',
}
package {'libapache2-mod-php5':
ensure => present,
}
package {'phpmyadmin':
ensure => present,
}
package {'libapache2-mod-auth-mysql':
ensure => present,
}
package {'php5-mysql':
ensure => present,
}
package {'php5-mcrypt':
ensure => present,
}
exec {'mysqladmin -u root password 123@India && touch /var/flagmysqlroot':
path => '/usr/bin',
creates => '/var/flagmysqlroot',
}
file {'/root/mysqlcommands':
ensure => present,
source => "puppet:///modules/drupal/mysqlcommands",
}
exec {'mysql -uroot -p123@India </root/mysqlcommands && touch /var/flagmysql1':
path => '/usr/bin',
creates => '/var/flagmysql1',
}
package {'php5-gd':
ensure => present,
}
package {'php5-curl':
ensure => present,
}
package {'libssh2-php':
ensure => present,
}
exec {'wget http://ftp.drupal.org/files/projects/drupal-7.32.tar.gz':
cwd => '/var/www/html',
path => '/usr/bin',
}
exec {'tar -zxvf drupal-7.32.tar.gz':
cwd => '/var/www/html',
path => '/bin',
}
exec {'rsync -avP drupal-7.32/ .':
cwd => '/var/www/html',
path => '/usr/bin',
}
exec {'mkdir -p sites/default/files':
cwd => '/var/www/html',
path => '/bin',
}
exec {'cp /var/www/html/sites/example.sites.php /var/www/html/sites/default/settings.php':
path => '/bin',
}
exec {'chmod 777 /var/www/html/sites/default/settings.php':
path => '/bin',
}
exec {'chown -R www-data:www-data /var/www/html':
path => '/bin',
}
exec {'mv /var/www/html/index.html /var && touch /var/flagindex':
path => '/bin',
creates => '/var/flagindex',
}
}
