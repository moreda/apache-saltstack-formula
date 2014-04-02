{% if grains['os_family']=="Debian" %}
include:
  - apache


libapache2-mod-fastcgi:
  pkg:
    - installed


a2enmod fastcgi:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/fastcgi.load
    - require:
      - pkg: libapache2-mod-fastcgi
    - watch_in:
      - service: apache
{% endif %}
