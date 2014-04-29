{% from "apache/map.jinja" import apache with context %}


{% if grains['os_family']=="Debian" %}
include:
  - apache


a2enmod proxy_fcgi:
  cmd:
    - run
    - unless: ls /etc/apache2/mods-enabled/proxy_fcgi.load
    - require:
      - pkg: apache
      - cmd: a2enmod proxy
    - watch_in:
      - service: apache
{% endif %}
