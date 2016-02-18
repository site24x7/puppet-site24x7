class site24x7($api_key=$site24x7::params::site24x7agent_apikey,$agent_uninstaller=$site24x7::params::site24x7agent_uninstall,$agent_proxy=$site24x7::params::site24x7agent_proxy) inherits site24x7::params{

notify{'site24x7 linux monitoring agent installation started':}

include site24x7::linuxagent
include site24x7::params

notify{'site24x7 linux monitoring agent installation completed':}

}

