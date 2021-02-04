# resolver Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/resolver.svg)](https://supermarket.chef.io/cookbooks/resolver)
[![CI State](https://github.com/sous-chefs/resolver/workflows/ci/badge.svg)](https://github.com/sous-chefs/resolver/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Configures /etc/resolv.conf, unless the nameservers attribute is empty. Search will be excluded if empty.

## Requirements

### Platforms

- AIX
- Debian/Ubuntu
- RHEL/CentOS/Scientific/Amazon/Oracle
- Fedora
- FreeBSD/OpenBSD
- macOS
- Solaris
- openSUSE / SUSE Enterprise

### Chef

- Chef 12.1+

### Cookbooks

- none

## Attributes

See `attributes/default.rb` for default values.

- `node['resolver']['search']` - an array of search domains for host-name lookup; a string may also be provided for backwards compatibility. Limited to 6 elements and 256 characters.
- `node['resolver']['nameservers']` - Required, an array of nameserver IP address strings; the default is an empty array, and the default recipe will not change resolv.conf if this is not set. See **Usage**.
- `node['resolver']['options']` - a hash of resolv.conf options. See **Usage** for examples.
- `node['resolver']['domain']` - Local domain name. if `nil`, the domain is determined from the local hostname returned by `gethostname(2)`.

## Recipes

### default

Configure /etc/resolv.conf based on attributes.

## Usage

Using the default recipe, set the resolver attributes in a role, for example from my base.rb:

```ruby
"resolver" => {
  "nameservers" => ["10.13.37.120", "10.13.37.40"],
  "search" => [ "int.example.org", "ext.example.org" ],
  "options" => {
    "timeout" => 2, "rotate" => nil
  }
}
```

The resulting `/etc/resolv.conf` will look like:

```text
search int.example.org ext.example.org
nameserver 10.13.37.120
nameserver 10.13.37.40
options timeout:2 rotate
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
