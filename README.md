What is it?
===========

Puppet module install and configure [beaver](https://github.com/josegonzalez/beaver) for shipping logs to logstash.
Currently only redis is supported as the transport, but it would be easy to 
support additional transports.

Note: Beaver 29 or greater is now required because of the switch to conf.d style config

Usage:
------

You an install the module by just defining a logfile you'd like to ship if the
beaver defaults work for you.

### Example configuration with manifests
<pre>
  beaver::stanza { '/var/log/messages':
    type    => 'syslog',
    tags    => ['messages', 'prod'],
  }
</pre> 

If beaver configuration is required, just specify it in the class:
<pre>
  class { 'beaver':
    redis_host      => 'logstash.example.org',
    redis_namespace => 'logstash::prod'
  }
</pre>

### Example configuration with hiera
Here it is assumed that the classes are loaded from hiera automatically [(more info on puppetlabs)](https://docs.puppetlabs.com/hiera/1/puppet.html#assigning-classes-to-nodes-with-hiera-hierainclude).
```
---
classes:
  - beaver

beaver::stanzas:
  /var/log/messages:
     type: 'syslog',
     tags: ['messages', 'prod' ]

beaver::redis_host: 'iipc-ulog01'
beaver::redis_namespace: 'logstash'
beaver::logstash_version: '1'
```

TODO:
-----
[] Support additional transports
[] Support adding environment fields

License:
--------
Released under the Apache 2.0 licence

Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
