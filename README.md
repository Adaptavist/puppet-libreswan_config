
# libreswan_config Module
[![Build Status](https://travis-ci.org/Adaptavist/puppet-libreswan_config.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-libreswan_config)

## Overview

The **puppet-libreswan_config.** installs and configures libreswan on any node where it has been included, 
it allows ipsec config, connections and secrets to be defined in hiera

## Configuration


`libreswan_config::purge_configdir`

Flag to determine if libreswan shoule remove unmanaged configs, defaults to **false**

`libreswan_config::ipsec_config`

Hash of global ipsec configuration, defaults to **empty hash**

`libreswan_config::secrets`

Hash of secrets, defaults to **empty hash**

`libreswan_config::connections`

Hash of connections, defaults to **empty hash**

`libreswan_config::service_name'

The service name, defaults to **ipsec**

## Example Hiera Usage:
 
    libreswan_config::purge_configdir: false
    libreswan_config::ipsec_config:
      listen: "192.168.55.1"
      dumpdir: ""/var/run/pluto/"
      nat_traversal: "no"
      virtual_private: "%v4:192.168.55.0/24,%v4:192.168.56.0/24"
      oe: "off"
      protostack: "netkey"
      plutostderrlog: "/var/log/pluto.log"
      force_keepalive: "yes"
      keep_alive: "60"
    libreswan_config::secrets:
      'client-secret':
        ensure: 'present'
        id: '192.168.55.1 192.168.56.1'
        type: 'PSK'
        secret: 'super-secret-psk'
    libreswan_config::connections:
      "client-connection":
        ensure: "present"
        options:
          authby: "secret"
          pfs: "yes"
          auto: "start"
          keyingtries: "%forever"
          keylife: "1h"
          ike: "aes256-sha1-modp1024"
          esp: "aes256-sha1;modp1536"
          ikelifetime: "86400s"
          type: "tunnel"
          left: "192.168.55.1"
          leftsubnet: "192.168.55.0/24"
          leftnexthop: "%defaultroute"
          leftsourceip: "192.168.55.1"
          aggrmode: "no"
          right: "192.168.56.1"
          leftsubnet: "192.168.56.0/24"
          rightnexthop: "%defaultroute"
          rightsourceip: "192.168.56.1"
          dpddelay: "10"
          dpdtimeout: "3600"
          dpdaction: "restart"



## Dependencies

This module depends on the following puppet modules:

* libreswan
