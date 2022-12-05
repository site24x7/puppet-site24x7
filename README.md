Bulk deployment of Site24x7 Linux agent using Puppet
===========

This puppet recipe installs Site24x7 Server Monitoring agent on Linux platforms. Please create a Site24x7 account to install the Linux agent using Puppet. Sign Up Now for a Free Trial!  


Supported Platforms 
============

All Linux platforms with Glibc version - 2.5 and above,  including Centos, Debian, Fedora, 
Redhat, Suse, Ubuntu

Prerequisite
============
curl - Needed to download install file in all puppet agent machines

Installation Steps
============

1. Download the Site24x7 module into your puppet modules directory of puppet master machine. Note: Module directory name must be site24x7.

2. Edit the file, "/etc/puppetlabs/code/environments/production/modules/site24x7/manifests/params.pp" to enter your device key.

3. Set '$site24x7agent_devicekey' with your unique Site24x7 device Key.   
 	Example - $site24x7agent_devicekey = 'xxxxxxxxxxxxxxxxxxxxxxxx'

4. Set proxy attribute if required.   
 	Example - $site24x7agent_proxy= "user:password@proxyhost:proxyport"

5. If proxy is needed for downloading Site24x7Linux agent, kindly uncomment the environment value in download_handler.pp. This assumes, the proxy you have mentioned in params.pp is the proxy needed for downloading the agent file.

6. Edit the file, "/etc/puppetlabs/code/environments/production/manifests/site.pp" to include site24x7 module and to specify the machine on which you want site24x7 agent.

Example - To install in all puppet agent machines

    node  default
    {
            class { 'site24x7': }
    }
Example - To install in specific puppet agent machines

    node "hostname1","hostname2"
    {
          class { 'site24x7': }
    }
Note: Hostname is the hostname of puppet agents. should be within quotes

Your puppet master machine will automatically installs site24x7 agent in all puppet agents (after the configured interval in puppet agent's puppet.conf, default 30 minutes). If it doesnt, Kindly execute following command in needed puppet agent machines.

    puppet agent -t
View your servers from your Site24x7 account, https://www.site24x7.com/login.html.

Params
============

$site24x7agent_devicekey - Log in to Site24x7 page and navigate to Home > Click on the (+) icon on Monitor > click "Linux Server Monitoring". You can find the key in the command panel. Site24x7 device key is unique for your account. Alternate device Key can also be generated from your Site24x7 account under Admin > Developer > Device Key.

$site24x7agent_proxy - Proxy server required to connect to the Site24x7 servers. Example : user:password@proxyhost:proxyport

$automation - Enable/Disable IT automation on your Site24x7 agents. By default, it will be "true". To disable IT automation, use $automation=false 

Un-Installation Steps
============
Execute the command in puppet master machine

        puppet module uninstall site24x7-site24x7_agent --ignore-changes
	
Related Links
=====
* [Site24x7 Server Monitoring] (https://www.site24x7.com/server-monitoring.html)
* [Site24x7 Signup] (https://www.site24x7.com/signup.html?pack=5&l=en)
* [Site24x7 Help Documentation] (https://www.site24x7.com/help/admin/adding-a-monitor/linux-server-monitoring.html)

License
=======

(The MIT License)

Copyright © 2015, 2016 Site24x7
Terms of Use (http://www.site24x7.com/terms.html)
Privacy Policy (http://www.site24x7.com/privacypolicy.html)
Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without
limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons
to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
