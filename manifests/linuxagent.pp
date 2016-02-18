class site24x7::linuxagent inherits site24x7{

$customer_id=$site24x7::api_key
$agent_uninstall=$site24x7::agent_uninstaller
$agent_proxy=$site24x7::site24x7agent_proxy
$local = $site24x7::local_setup
$os_arch = $architecture

notify {"OS Architecture : ${os_arch}":}
#notify{"Agent Uninstall : ${agent_uninstall}":}
notify{"API KEY  : ${customer_id}":}
notify{"Proxy Info  : ${agent_proxy}":}
#notify{"Local Setup  : ${local}":}

if $os_arch=="amd64"
{
$install_file="Site24x7_Linux_64bit.install"
}
else
{
$install_file="Site24x7_Linux_32bit.install"
}

notify {"File To Download : ${install_file}":}

if $osfamily=="windows"
{
notify{'Failed installing agent ${api_key}':}
}
else
{
if $customer_id!=""
{

file {'/tmp/site24x7agent':
ensure=>directory,
mode=>"0755",
}

exec {'Site24x7 Linux Agent':
unless => "/usr/bin/test -f /tmp/site24x7agent/Linux_Agent.install",
command => "/usr/bin/curl https://staticdownloads.site24x7.com//server//${install_file} > /tmp/site24x7agent/Linux_Agent.install",
creates => "/tmp/site24x7agent/Linux_Agent.install",
notify => File["/tmp/site24x7agent/Linux_Agent.install"],
require => File["/tmp/site24x7agent"]
}

file {'/tmp/site24x7agent/Linux_Agent.install':
require => Exec['Site24x7 Linux Agent'],
mode => "0755",
#notify => Exec['Install Linux Agent'],
}


if $agent_proxy==""
{
exec{'Install Linux Agent':
path=>"/tmp/site24x7agent/",
unless => "/usr/bin/test -f /opt/site24x7/monagent",
command => "/tmp/site24x7agent/./Linux_Agent.install -i -key=${customer_id}",
creates => "/opt/site24x7/monagent/bin/monagent",
notify => Notify['Succesully Completed'],
require => File['/tmp/site24x7agent/Linux_Agent.install'],
}
}
else
{
exec{'Install Linux Agent With Proxy':
path=>"/tmp/site24x7agent/",
unless => "/usr/bin/test -f /opt/site24x7/monagent",
command => "/tmp/site24x7agent/./Linux_Agent.install -i -key=${customer_id} -proxy=${agent_proxy}",
creates => "/opt/site24x7/monagent/bin/monagent",
notify => Notify['Succesully Completed'],
require => File['/tmp/site24x7agent/Linux_Agent.install'],
}
}

notify {'Succesully Completed':}

exec {'remove_tmp_directory':
path=>'/tmp/site24x7agent/Linux_Agent.install',
command => "/bin/rm -rf /tmp/site24x7agent/Linux_Agent.install"
}

}

if $agent_uninstall=="true"
{

file {'/opt/site24x7/monagent/bin/uninstall':
ensure=>present
}

exec {'Uninstall Site24x7 Linux Agent':
command => "/opt/site24x7/monagent/bin/uninstall",
notify => Notify["Site24x7 monitoring agent uninstalled successfully"],
require => File["/opt/site24x7/monagent/bin/uninstall"]
}
notify {'Site24x7 monitoring agent uninstalled successfully':}		
}

}
}
