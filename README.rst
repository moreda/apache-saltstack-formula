==============
apache-formula
==============

A saltstack formula to configure apache.

This formula has been developed distributing id and state declarations in
different files to make it usable in most situations. It should be useful from
scenarios with a simple install of the package (without any special
configuration) to a complete set-up with virtual hosts.

Any special needs could be addressed forking the formula repo, even in-place at
the server acting as master. I'm trying to keep this as general as possible and
further general improvements would be added.

The ``files`` directory is structured using a ``default`` root and
optional ``<minion-id>`` directories:

.. code:: asciidoc

    files
      |-- default
      |        |-- etc
      |        |    |-- foo.conf
      |        |    `-- bar.conf
      |        `-- usr/share/thingy/*
      `-- <minion-id>
              |-- etc
              |    |-- foo.conf
              |    `-- bar.conf
              `-- usr/share/thingy/*

This way we have certain flexibility to use different files for different
minions. **It's not designed to substitute pillar data**. Remember that
pillar has to be used for info that it's essential to be only known for a
certain set of minions (i.e. passwords, private keys and such).

.. note::

    So far this is mostly designed for Debian os_family and apache 2.4.x.
    Support for RedHat os_family will be appearing increasingly.

    At this moment, the organization of sites (we can assume site == virtual
    host) is completelly based in a Debian os_family organization. Soon I'll try
    to implement the RedHat flavor that drops everything in a conf.d directory.

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
================

.. contents::
    :local:

``apache``
----------

Installs the package and starts the associated service.

``apache.conf``
---------------

Configures the service and sites using info provided in pillar and templates.

``apache.repo``
---------------

Configures a repository to get alternative (usually updated) versions of the
packages different than the ones provided by the default repository.

``apache.users``
----------------

Declares users and groups that could be needed even in other formulas
(e.g. in the users formula to make an user pertain to the service group).

``apache.mod_actions``
----------------------

Installs the mod_actions module.

``apache.mod_pagespeed``
------------------------

Installs the mod_pagespeed module.

``apache.mod_proxy``
--------------------

Installs the mod_proxy module.

``apache.mod_proxy_fcgi``
-------------------------

Installs the mod_proxy_fcgi module.

``apache.mod_rewrite``
----------------------

Installs the mod_rewrite module.
