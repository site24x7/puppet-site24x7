class site24x7($device_key=$site24x7::params::site24x7agent_devicekey, $agent_proxy=$site24x7::params::site24x7agent_proxy, $automation=$site24x7::params::automation) inherits site24x7::params{

include site24x7::linuxagent
}

