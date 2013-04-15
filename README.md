What is it?
===========

Puppet module install and configure [beaver](https://github.com/josegonzalez/beaver) for shipping logs to logstash.
Currently only redis is supported as the transport, but it would be easy to 
support additional transports.

Usage:
------

You an install the module by just defining a logfile you'd like to ship if the
beaver defaults work for you or if you are using puppet >= 3.0 with hiera:
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
