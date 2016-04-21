# apt-get install puppet

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

file{ '/root/.ssh/':
	ensure => 'directory',
}
->
file{ '/root/.ssh/authorized_keys':
    ensure => 'present',
    content => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCslNKgLyoOrGDerz9pA4a4Mc+EquVzX52AkJZz+ecFCYZ4XQjcg2BK1P9xYfWzzl33fHow6pV/C6QC3Fgjw7txUeH7iQ5FjRVIlxiltfYJH4RvvtXcjqjk8uVDhEcw7bINVKVIS856Qn9jPwnHIhJtRJe9emE7YsJRmNSOtggYk/MaV2Ayx+9mcYnA/9SBy45FPHjMlxntoOkKqBThWE7Tjym44UNf44G8fd+kmNYzGw9T5IKpH1E1wMR+32QJBobX6d7k39jJe8lgHdsUYMbeJOFPKgbWlnx9VbkZh+seMSjhroTgniHjUl8wBFgw0YnhJ/90MgJJL4BToxu9PVnH ondrej@ondrejsika.com',
    recurse => true,
}