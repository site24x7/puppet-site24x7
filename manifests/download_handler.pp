class site24x7::download_handler{
    file {'/tmp/site24x7agent':
	ensure=>directory,
	mode=>"0755",
	}
	exec {'Site24x7 Linux Agent':
	unless => "/usr/bin/test -f /tmp/site24x7agent/Linux_Agent.install",
	command => "/usr/bin/curl -k https://staticdownloads.site24x7.com//server//$site24x7::linuxagent::install_file > /tmp/site24x7agent/Linux_Agent.install",
	creates => "/tmp/site24x7agent/Linux_Agent.install",
	notify => File["/tmp/site24x7agent/Linux_Agent.install"],
	require => File["/tmp/site24x7agent"]
	}

	file {'/tmp/site24x7agent/Linux_Agent.install':
	require => Exec['Site24x7 Linux Agent'],
	mode => "0755",
	#notify => Exec['Install Linux Agent'],
	}

}
