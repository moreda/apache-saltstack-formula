{% from "apache/map.jinja" import apache with context %}


{% if grains['os_family']=="Debian" %}
include:
  - apache


a2enmod actions:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/actions.load
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
{% endif %}
