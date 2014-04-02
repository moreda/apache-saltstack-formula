================
apache-formula
================

A saltstack formula to configure apache.

.. note::

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
================

.. contents::
    :local:

``apache``
------------

Installs the apache package, and starts the associated template service.

``conf``
------------

Configures apache.

TODO: So far this is just for Debian/Ubuntu. Support
additional os_family values as RedHat.

``mod_actions``
------------

Installs the mod_actions module.

TODO: So far this is just for Debian/Ubuntu. Support
additional os_family values as RedHat.

``mod_fastcgi``
------------

Installs the mod_fastcgi module.

TODO: So far this is just for Debian/Ubuntu. Support
additional os_family values as RedHat.
