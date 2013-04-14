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

file { '/home/dan/.fonts':
  owner => 'dan',
  group => 'dan',
  mode => '644',
  ensure => directory,
}

git::repo{ 'powerline':
 owner => 'dan',
 group => 'dan',
 branch => 'develop',
 update => true,
 path => '/home/dan/powerline',
 source => 'https://github.com/Lokaltog/powerline.git',
}

file { 'PowerlineSymbols.otf':
  path => '/home/dan/.fonts/PowerlineSymbols.otf',
  owner => 'dan',
  group => 'dan',
  mode => '644',
  ensure => file,
  source => '/home/dan/powerline/font/PowerlineSymbols.otf',
  require => Git::Repo['powerline'],
}

file { '/home/dan/.config/fontconfig/conf.d':
  path => '/home/dan/.config/fontconfig/conf.d',
  owner => 'dan',
  group => 'dan',
  mode => '644',
  ensure => directory,
}

file { '10-powerline-symbols.conf':
  path =>'/home/dan/.config/fontconfig/conf.d/10-powerline-symbols.conf',
  owner => 'dan',
  group => 'dan',
  mode => '644',
  ensure => file,
  source => '/home/dan/powerline/font/10-powerline-symbols.conf',
  require => Git::Repo['powerline'],
}

exec { '/usr/bin/fc-cache -v -f':
  subscribe => [ File['PowerlineSymbols.otf'],
                 File['10-powerline-symbols.conf'],
  ],
  refreshonly => true,
}
