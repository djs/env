class { git:
    gui => true,
}

package { 'vim-gnome':
    ensure => latest,
}

git::repo{'vimconfig':
 owner => 'dan',
 group => 'dan',
 update => true,
 path   => '/home/dan/vimconfig',
 source => 'https://github.com/djs/vimconfig.git'
}

file { '/home/dan/.vimrc':
 owner => 'dan',
 group => 'dan',
 mode => '644',
 ensure => link,
 target => 'vimconfig/_vimrc',
 require => Git::Repo['vimconfig'],
}

file { '/home/dan/.vim':
 owner => 'dan',
 group => 'dan',
 mode => '644',
 ensure => directory,
}

file { '/home/dan/.vim/tmp':
 owner => 'dan',
 group => 'dan',
 mode => '640',
 ensure => directory,
 require => File['/home/dan/.vim'],
}

file { '/home/dan/.vim/bundle':
 owner => 'dan',
 group => 'dan',
 mode => '644',
 ensure => directory,
 require => File['/home/dan/.vim'],
}

git::repo{ 'vundle':
 owner => 'dan',
 group => 'dan',
 update => true,
 path => '/home/dan/.vim/bundle/vundle',
 source => 'https://github.com/gmarik/vundle.git',
 require => File['/home/dan/.vim'],
}

class { 'sudo': }
sudo::conf { 'dan':
  priority => 10,
  content => "dan ALL=(ALL) NOPASSWD: ALL\n",
}

class { 'envy15': }
