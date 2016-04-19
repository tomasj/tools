exec { 'update_apt':
  command => 'apt-get update',
  cwd => "/root/",
}
->
exec { 'resolve_webmin_dependencies':
  command => 'apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python',
  cwd => "/root/",
}
->
exec { 'download_webmin_install':
  command => 'wget http://prdownloads.sourceforge.net/webadmin/webmin_1.791_all.deb',
  cwd => "/root/",
}

