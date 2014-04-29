{% from "apache/map.jinja" import apache with context %}


include:
  - apache


# This adds a conveniently updated repo for apache2
{%if salt['grains.get']('os_family') == 'Debian' %}
apache_repo:
  pkgrepo:
    - managed
    - ppa: ondrej/php5
    - require:
      - cmd: apache_repo
  cmd:
    - run
    - name: /usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C
    - unless: /usr/bin/apt-key adv --list-key E5267A6C
    - user: root
{% endif %}
