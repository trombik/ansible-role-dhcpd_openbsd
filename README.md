# ansible-role-dhcpd-openbsd

Manage `dhcpd(8)` from OpenBSD project.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `dhcpd_openbsd_package` | package name of OpenBSD `dhcpd` | `{{ __dhcpd_openbsd_package }}` |
| `dhcpd_openbsd_user` | user name of OpenBSD `dhcpd` | `{{ __dhcpd_openbsd_user }}` |
| `dhcpd_openbsd_group` | group name of OpenBSD `dhcpd` | `{{ __dhcpd_openbsd_group }}` |
| `dhcpd_openbsd_service` | service name of OpenBSD `dhcpd` | `{{ __dhcpd_openbsd_service }}` |
| `dhcpd_openbsd_conf_dir` | `basedir` of `dhcpd.conf(5)` | `{{ __dhcpd_openbsd_conf_dir }}` |
| `dhcpd_openbsd_conf_file` | path to `dhcpd.conf(5)` | `{{ __dhcpd_openbsd_conf_dir }}/dhcpd.conf` |
| `dhcpd_openbsd_flags` | optional flags for OpenBSD `dhcpd` | `""` |
| `dhcpd_openbsd_conf` | content of `dhcpd.conf(5)` | `""` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__dhcpd_openbsd_user` | `dhcpd` |
| `__dhcpd_openbsd_group` | `dhcpd` |
| `__dhcpd_openbsd_service` | `dhcpd` |
| `__dhcpd_openbsd_conf_dir` | `/usr/local/etc` |
| `__dhcpd_openbsd_package` | `net/dhcpd` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__dhcpd_openbsd_user` | `_dhcpd` |
| `__dhcpd_openbsd_group` | `_dhcpd` |
| `__dhcpd_openbsd_service` | `dhcpd` |
| `__dhcpd_openbsd_conf_dir` | `/etc` |
| `__dhcpd_openbsd_package` | `""` |

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-dhcpd-openbsd
  vars:
    dhcpd_openbsd_flags: em0
    dhcpd_openbsd_conf: |
      option domain-name "i.trombik.org";
      option domain-name-servers 127.0.0.1;
      default-lease-time 600;
      max-lease-time 7200;

      subnet 10.0.2.0 netmask 255.255.255.0 {
        range 10.0.2.100 10.0.2.200;
        option broadcast-address 10.0.2.255;
        option routers 10.0.2.2;
      }
```

# License

```
Copyright (c) 2017 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>

This README was created by [qansible](https://github.com/trombik/qansible)
