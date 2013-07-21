Description
===========

Configures /etc/resolv.conf, unless the nameservers attribute is
empty.

Attributes
==========

See `attributes/default.rb` for default values.

* `node['resolver']['search']` - the search domain to use
* `node['resolver']['nameservers']` - Required, an array of nameserver
  IP address strings; the default is an empty array, and the default
  recipe will not change resolv.conf if this is not set. See
  __Usage__.
* `node['resolver']['options']` - a hash of resolv.conf options. See
  __Usage__ for examples.
* `nodes['resolver']['search_query']` - search query to execute to
  find resolvers
* `nodes['resolver']['search_attributes']` - these attributes will be
  used in 'nameserver' lines

Recipes
=======

Use one of the recipes to set up /etc/resolv.conf for your system(s).

## default

Configure /etc/resolv.conf based on attributes.

## from_server_role

Configure /etc/resolv.conf's nameservers based on a search for a
specific role (by Chef environment).

## from_search

Configure /etc/resolv.conf's nameservers based on an arbitrary search.

Usage
=====

Using the default recipe, set the resolver attributes in a role, for example from my base.rb:

    "resolver" => {
      "nameservers" => ["10.13.37.120", "10.13.37.40"],
      "search" => "int.example.org",
      "options" => {
        "timeout" => 2, "rotate" => nil
      }
    }

The resulting /etc/resolv.conf will look like:

    domain int.example.org
    search int.example.org
    nameserver 10.13.37.120
    nameserver 10.13.37.40
    options timeout:2 rotate

Using the `from_server_role` recipe, assign the
`node['resolver']['server_role']` attribute's role to a system that is
the DNS resolver in the same Chef environment.

The from_search recipe can be used to find resolvers based on any search query.
The two attributes involved are `search_query` and `search_attributes`.
`search_query` defines the query to be used - interpolation is delayed, so
strings like `"#{node.chef_environment}"` will produce the output you'd expect.
`search_attributes` is an array that defines which attributes will be pulled
from the search results to be used as the actual server addresses. Typically,
you should just use the default, which is just `['ipaddress']`. If you want
any IPv6 addresses to be included as well, you can set add to this array to
`['ipaddress', 'ip6address']`.

This example JSON will write a /etc/resolv.conf containing servers in the
same environment as this machine, with the resolver role.

    "resolver": {
      "search_query": "role:resolver AND chef_environment:#{node.chef_environment}"
    }

License and Author
==================

Author:: Joshua Timberman (<joshua@opscode.com>)

Copyright 2009-2012, Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
