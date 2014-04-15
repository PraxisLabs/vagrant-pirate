Vagrant-Pirate
==============

[![Build Status](https://travis-ci.org/PraxisLabs/vagrant-pirate.svg?branch=master)](https://travis-ci.org/PraxisLabs/vagrant-pirate) [![Coverage Status](https://coveralls.io/repos/PraxisLabs/vagrant-pirate/badge.png)](https://coveralls.io/r/PraxisLabs/vagrant-pirate) [![Dependency Status](https://gemnasium.com/PraxisLabs/vagrant-pirate.png)](https://gemnasium.com/PraxisLabs/vagrant-pirate) [![Gem Version](https://badge.fury.io/rb/vagrant-pirate.png)](http://badge.fury.io/rb/vagrant-pirate)


Standard Installation
---------------------

To install this gem, use the Vagrant 'plugin' command:

```
vagrant plugin install vagrant-pirate
```

This will keep it isolated from system-wide and other gems.


Git Installation
----------------

To install from git you will need the Rake gem and all its dependencies.

You can download the latest development version from
https://github.com/PraxisLabs/vagrant-pirate

```
git clone https://github.com/PraxisLabs/vagrant-pirate.git
```

You will then need to build the gem manually:

```
rake build
```

This will create a gem in the 'pkg' folder. You can then install it as a plugin:

```
vagrant plugin install pkg/vagrant-pirate.gem
```

Usage
-----

To initialize a new project:

```
vagrant pirate init [box-name] [box-url]
```

To update an existing project with the latest Vagrantfile that Vagrant-Pirate
provides:

```
vagrant pirate update
```


Vagrantfile
-----------

Vagrant-Pirate provides a custom Vagrantfile. This Vagrantfile parses the Yaml
config files in the 'enabled.d' directory, and applies any settings found
there. The Vagrant name for the VM is the name of the file (without the '.yaml'
extension, obviously). Multi-VM environments are supported by adding additional
Yaml config files.

As with a standard Vagrantfile, the one this gem provides can be altered to
suit the needs of your project. However, be aware that running the 'vagrant
pirate update' command will overwrite any changes you make. Of course, this
should not be a problem, since you are keeping your project directory under
some form of version control, right?


Config files
------------

All Vagrant VM configuration can be done from Yaml config files. Only config
files in the 'enabled.d' directory are interpreted. You can copy from, or
symlink to, files in the 'available.d' directory. This allows you to have a
library of config files that could, for example, be updated by an external
application.


Yaml
----

To see what you can do with Yaml, check out this handy reference card:
http://www.yaml.org/refcard.html. To see how Yaml is interpreted in Ruby, see
this guide: http://yaml.org/YAML_for_ruby.html. For further details, refer to
the full Yaml specification: http://www.yaml.org/spec/1.2/spec.html


Vagrant Options
---------------

For all available Vagrant options, see the docs on Vagrantfile settings:
https://docs.vagrantup.com/v2/vagrantfile/index.html. While we have provided
some examples below, it is far from exhaustive. If you cannot figure out how to
apply a particular setting, please file a support request at:
https://github.com/ergonlogic/vagrant-pirate.


Free Software
-------------

This gem is published under the GNU GPLv3 (General Public License, Version 3),
and as such is, and will always remain, free software. Engagement in the
development process by users and other developers is strongly encouraged. So,
please feel free to post to the project wiki, and submit feature and pull
requests.


CREDITS
-------

Developed and maintained by Praxis Labs Coop <http://praxis.coop/>

Sponsored by Poetic Systems <http://poeticsystems.com/>
