{% from "apache/map.jinja" import apache with context %}


include:
  - apache
  # We assume that we always want the actions module
  - apache.mod_actions


extend:
  apache:
    user:
      - present
      - name: {{ salt['pillar.get']('apache:user') | default('www-data') }}
      - require:
        - pkg: apache
    group:
      - present
      - name: {{ salt['pillar.get']('apache:group') | default('www-data') }}
      - require:
        - pkg: apache


{{ apache.config }}:
  file:
    - managed
    - template: jinja
    - source:
      - salt://apache/files/{{ grains['id'] }}/etc/apache2/apache2.conf.jinja
      - salt://apache/files/default/etc/apache2/apache2.conf.jinja
    - require:
      - pkg: apache
    - watch_in:
      - service: apache


/etc/apache2/envvars:
  file:
    - managed
    - template: jinja
    - source:
      - salt://apache/files/{{ grains['id'] }}/etc/apache2/envvars.jinja
      - salt://apache/files/default/etc/apache2/envvars.jinja
    - require:
      - pkg: apache
    - watch_in:
      - service: apache


{% for site in salt['pillar.get']('apache:sites', []) %}
{% set site_attr = salt['pillar.get']('apache:sites:' ~ site) %}
/etc/apache2/sites-available/{{ site }}:
  file:
    - managed
    - source:
      - salt://apache/files/{{ grains['id'] }}/etc/apache2/sites-available/{{ site_attr['template'] }}.jinja
      - salt://apache/files/default/etc/apache2/sites-available/{{ site_attr['template'] }}.jinja
    - template: jinja
    - context:
        site: {{ site }}
    - require:
      - pkg: apache
    - watch_in:
      - service: apache


/etc/apache2/sites-enabled/{{ site }}:
  file:
    - symlink
    - target: /etc/apache2/sites-available/{{ site }}
    - require:
      - pkg: apache
    - watch_in:
      - service: apache


{{ site_attr['document_root'] }}:
  file:
    - directory
    - user: {{ site_attr['user'] }}
    - group: {{ site_attr['group'] }}
    - mode: 2755
    - require:
      - user: {{ site_attr['user'] }}
      - group: {{ site_attr['group'] }}
    - require_in:
      - service: apache


{{ site_attr['log_dir'] }}:
  file:
    - directory
    - user: {{ site_attr['user'] }}
    - group: {{ site_attr['group'] }}
    - mode: 775
    - require:
      - user: {{ site_attr['user'] }}
      - group: {{ site_attr['group'] }}
    - require_in:
      - service: apache
{% endfor %}


{% for site in salt['pillar.get']('apache:disabled_sites',[]) %}
/etc/apache2/sites-enabled/{{ site }}:
  file:
    - absent
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
{% endfor %}


{% for site in salt['pillar.get']('apache:absent_sites',[]) %}
/etc/apache2/sites-enabled/{{ site }}:
  file:
    - absent
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
/etc/apache2/sites-available/{{ site }}:
  file:
    - absent
    - require:
      - pkg: apache
    - watch_in:
      - service: apache
{% endfor %}
