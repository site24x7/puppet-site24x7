class site24x7::installation_handler{
	
	exec{'Install Linux Agent With Proxy':
	path=>"/tmp/site24x7agent/",
	unless => "/usr/bin/test -d /opt/site24x7/monagent",
	command => "$site24x7::linuxagent::command",
	creates => "/opt/site24x7/monagent/bin/monagent",
	notify => Notify['Successfully Installed'],
	require => File['/tmp/site24x7agent/Linux_Agent.install'],
	}

	notify {'Successfully Installed':}

	exec {'remove_tmp_directory':
		path=>'/tmp/site24x7agent/Linux_Agent.install',
		command => "/bin/rm -rf /tmp/site24x7agent/Linux_Agent.install"
	}

}