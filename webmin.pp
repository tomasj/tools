# apt-get install puppet

# --------------- install webmin

exec { 'update_apt':
  command => 'apt-get -y update',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
->
exec { 'resolve_webmin_dependencies':
  command => 'apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
->
exec { 'download_webmin_install':
  command => 'wget http://prdownloads.sourceforge.net/webadmin/webmin_1.791_all.deb',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
->
exec { 'install_webmin':
  command => 'dpkg --install webmin_1.791_all.deb',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
# for webmin restart use
# /etc/init.d/webmin restart

# --------------- add ssh key

file{ '/root/.ssh/':
	ensure => 'directory',
}
->
file{ '/root/.ssh/authorized_keys':
    ensure => 'present',
    content => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCslNKgLyoOrGDerz9pA4a4Mc+EquVzX52AkJZz+ecFCYZ4XQjcg2BK1P9xYfWzzl33fHow6pV/C6QC3Fgjw7txUeH7iQ5FjRVIlxiltfYJH4RvvtXcjqjk8uVDhEcw7bINVKVIS856Qn9jPwnHIhJtRJe9emE7YsJRmNSOtggYk/MaV2Ayx+9mcYnA/9SBy45FPHjMlxntoOkKqBThWE7Tjym44UNf44G8fd+kmNYzGw9T5IKpH1E1wMR+32QJBobX6d7k39jJe8lgHdsUYMbeJOFPKgbWlnx9VbkZh+seMSjhroTgniHjUl8wBFgw0YnhJ/90MgJJL4BToxu9PVnH ondrej@ondrejsika.com',
    recurse => true,
}

# ----- puppet modules

exec { 'puppet_module_1':
  command => 'puppet module install puppetlabs-apache',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
exec { 'puppet_module_2':
  command => 'puppet module install puppetlabs-postgresql',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
exec { 'puppet_module_3':
  command => 'puppet module install puppetlabs-vcsrepo',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
exec { 'puppet_module_4':
  command => 'puppet module install puppetlabs-nodejs',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}

# ----- install phpPgAdmin + adminer

exec { 'phpPgAdmin':
  command => 'apt-get -y install php5-pgsql phppgadmin',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
->
file{ '/etc/apache2/sites-available/admin.metrocar.jezdito.cz.conf':
  ensure => 'present',
  content => '
      <VirtualHost *:80>
        ServerName admin.metrocar.jezdito.cz
        DocumentRoot /usr/share/phppgadmin
        DirectoryIndex index.php
      </VirtualHost>',
}
->
file{ '/etc/apache2/conf-available/phppgadmin.conf':
  ensure => 'absent',
}
->
file{ '/etc/apache2/conf-enabled/phppgadmin.conf':
  ensure => 'absent',
}
->
exec { 'a2ensite':
  command => 'a2ensite admin.metrocar.jezdito.cz.conf',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}
->
exec { 'restart_apache':
  command => 'service apache2 reload',
  cwd => "/root/",
  path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
}

# exec { 'adminer':
#   command => 'apt-get -y adminer',
#   cwd => "/root/",
#   path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
# }