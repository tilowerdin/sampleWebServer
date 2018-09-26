# sampleWebServer

## Configuration Overview

```
/etc/apache2/
|-- apache2.conf
|      `-- ports.conf
|-- mods-enabled
|      |-- *.load
|      `-- *.conf
|-- conf-enabled
|      `-- *.conf
|-- sites-enabled
       `-- *.conf
```

* `apache2.conf`: Hauptkonfigurationsdatei
* `*-enabled` Ordner: Konfigurationsteile für Module, globale Konfiguration und virtuelle Hosts
* aktiviert durch symlinking von verfügbaren Konfigurationen in `*-available` Ordnern
* zum aktivieren `a2enmod`, `a2dismod`, `a2ensite`, `a2dissite`, `a2enconf`, `a2disconf` benutzen
* starten und stoppen des Servers: `/etc/init.d/apache2`, `apache2ctl`

## Document Roots

* whitelist document roots in `apache2-conf`