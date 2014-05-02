{% from "apache/map.jinja" import apache with context %}


include:
  - apache


{% if grains['os_family']=="Debian" %}
libapache2-mod-pagespeed:
  pkg:
    - installed
    - sources:
      - mod-pagespeed-stable: https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb


a2enmod pagespeed:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/pagespeed.load
    - require:
      - pkg: libapache2-mod-pagespeed
    - watch_in:
      - service: apache
{% endif %}
