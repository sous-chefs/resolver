# resolver_config

[Back to resource list](../README.md#resources)

Introduced: v3.0.0

## Actions

- `:set`

## Properties

| Name                   | Type          | Default                          | Description                                                                     |
| ---------------------- | ------------- | -------------------------------- | --------------------------------------------------------------------------------|
| `config_file`          | String        | `/etc/resolv.conf`               | The path to the resolver configuration file on disk                             |
| `cookbook`             | String        | `resolver`                       | Cookbook to source configuration file template from                             |
| `template`             | String        | `resolv.conf.erb`                | Template to use to generate the configuration file                              |
| `owner`                | String        | Platform dependant               | Owner of the generated configuration file                                       |
| `group`                | String        | Platform dependant               | Group of the generated configuration file                                       |
| `mode`                 | String        | `'0644'`                         | Filemode of the generated configuration file                                    |
| `nameservers`          | String, Array | `nil`                            | The DNS servers to configure for system name resolution                         |
| `domain`               | String        | `nil`                            | The DNS domain name for the host                                                |
| `search`               | String, Array | `nil`                            | The DNS domain search list for the host                                         |
| `sortlist`             | String, Array | `nil`                            | The DNS sort list for the host                                                  |
| `options`              | Hash          | `nil`                            | Additional options to add to the resolver configuration file                    |
| `atomic_update`        | true, false   | `true`                           | Allow to Ran atomic file update (Could be used when updating inside a container |

## Examples

```ruby
resolver_config '/etc/resolv.conf' do
  nameservers ['1.1.1.1', '1.0.0.1']
  domain 'test.com'
  search ['test1.com', 'test2.com']
  options(
    'timeout' => 2
  )
end
```
