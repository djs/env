class envy15 {
    if $::operatingsystem == 'Ubuntu' {
        file {
        '/etc/init/hpenvy15-alsa.conf':
          owner => 'root',
          group => 'root',
          mode => '0644',
          source => 'puppet:///modules/envy15/hpenvy15-alsa.conf',
        }

        file {
        '/etc/init/radeon.conf':
          owner => 'root',
          group => 'root',
          mode => '0644',
          source => 'puppet:///modules/envy15/radeon.conf',
        }
    }
}
