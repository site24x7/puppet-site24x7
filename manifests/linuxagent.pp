class site24x7::linuxagent{

$customer_id=$site24x7::device_key
$agent_proxy=$site24x7::site24x7agent_proxy
$automation=$site24x7::automation
$local = $site24x7::local_setup
$os_arch = $architecture

if inline_template("<%= `/usr/bin/test -d /opt/site24x7/monagent && echo 'Yes' || echo 'No'` %>") == "No\n"{

  if $os_arch=="amd64" or $os_arch=="x86_64"
  {
    $install_file="Site24x7_Linux_64bit.install"
  }
  else
  {
    $install_file="Site24x7_Linux_32bit.install"
  }

  if $osfamily=="windows"
  {
    notify{'Failed installing agent ${device_key}':}
  }
h
  else{

    if $customer_id!=""{

    include site24x7::download_handler

    if $agent_proxy!=""
    {

        $command = "/tmp/site24x7agent/./Linux_Agent.install -i -key=${customer_id} -installer=puppet -automation=$automation -proxy=${agent_proxy}"
        include site24x7::installation_handler
    }

    if $agent_proxy=="" {

        $command = "/tmp/site24x7agent/./Linux_Agent.install -i -key=${customer_id} -automation=$automation -installer=puppet"
        include site24x7::installation_handler

    }

    notify {"Site24x7 Linux Agent installation in progress":}->  notify {"File To Download : ${install_file}":}->Class['site24x7::download_handler'] -> Class['site24x7::installation_handler']
  }
  else
  {
     notify {"Site24x7 device Key not provided":}
  }
  
  }
}

else{
  notify {"Site24x7 Linux agent already installed":}
  }

}
