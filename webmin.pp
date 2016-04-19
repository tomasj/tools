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

