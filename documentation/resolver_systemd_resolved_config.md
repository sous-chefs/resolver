# resolver_systemd_resolved_config

[Back to resource list](../README.md#resources)

Create and manage the systemd-resolved configuration file. (<https://www.freedesktop.org/software/systemd/man/resolved.conf.html>)

Introduced: v3.0.0

## Actions

- `:set`

## Properties

| Name                   | Type          | Default                          | Description                                                         |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- |
| `config_file`          | String        | `/etc/systemd/resolved.conf`     | The path to the systemd-resolved configuration file on disk         |
| `cookbook`             | String        | `resolver`                       | Cookbook to source configuration file template from                 |
| `template`             | String        | `resolved.conf.erb`              | Template to use to generate the configuration file                  |
| `owner`                | String        | Platform dependant               | Owner of the generated configuration file                           |
| `group`                | String        | Platform dependant               | Group of the generated configuration file                           |
| `mode`                 | String        | `'0644'`                         | Filemode of the generated configuration file                        |
| `dns`                  | String, Array | `nil`                            | A list of IPv4 and IPv6 addresses to use as system DNS servers      |
| `fallback_dns`         | String, Array | `nil`                            | A list of IPv4 and IPv6 addresses to use as fallback DNS servers    |
| `domains`              | String, Array | `nil`                            | A list of DNS search domains for the host                           |
| `llmnr`                | True, False, String | `nil`                      | Control Link-Local Multicast Name Resolution support (RFC 4795) on the host |
| `multicast_dns`        | True, False, String | `'resolve'`                | Control Multicast DNS support (RFC 6762) on the host                |
| `dnssec`               | True, False, String | `'allow-downgrade'`        | Control DNSSEC validation on the host                               |
| `dns_over_tls`         | True, False, String | `'opportunistic'`          | Control DNS-over-TLS on the host                                    |
| `cache`                | True, False, String | `true`                     | Control DNS caching on the host                                     |
| `cache_from_localhost` | True, False   | `false`                          | Control DNS caching of a result from a local address on the host    |
| `dns_stub_listener`    | True, False, String | `nil`                      | Control the DNS stub listener on the host                           |
| `dns_stub_listener_extra` | True, False, String | `nil`                   |Additional DNS stub sockets to listen on for the host                |
| `read_etc_hosts`       | True, False   | `true`                           | Control resolution of a hostname from the /etc/hosts file           |
| `resolve_unicast_single_label` | True, False | `false`                    | Control resolution of A and AAAA queries for single-label names over classic DNS |

## Examples

```ruby
resolver_systemd_resolved_config '/etc/systemd/resolved.conf' do
  dns ['1.1.1.1', '1.0.0.1', '2606:4700:4700::1111', '2606:4700:4700::1001']
  fallback_dns '8.8.8.8,8.8.4.4,2001:4860:4860::8888,2001:4860:4860::8844'
  domains 'localtest.com'
end
```
