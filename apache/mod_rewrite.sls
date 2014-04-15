{% if grains['os_family']=="Debian" %}
include:
  - apache


a2enmod rewrite:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/rewrite.load
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
{% endif %}
