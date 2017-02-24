# resolver Cookbook CHANGELOG

This file is used to list changes made in each version of the resolver cookbook.

## 2.0.1 (2017-02-24)

- Fix compatibility with old chef 12 clients
- Remove old recipe from the metadata
- Call out SUSE support in the readme and metadata

## 2.0.0 (2016-09-07)

- add support for 'domain' resolv.conf key
- Switch to root group to support AIX/OS X/FreeBSD
- Removed the from_server_role recipe. This should be done with a wrapper cookbook instead
- Add testing with Travis CI and use kitchen-dokken for integration testing
- Add basic Chefspec testing
- Add integration testing with Test Kitchen
- Add Berksfile
- Update contributing, testing and maintainers docs
- Improve the readme with chef/platform Requirements
- Add a Rakefile for simplified testing
- Use strings for file modes to preserve the leading 0s
- Add source_url, issue_url and chef_version to the metadata
- Remove attributes from the metadata since they weren't up to date

## v1.3.0 (2015-10-16)

- Add rubocop file and resolve all rubocop warnings
- Update the contributing doc to match the new process
- Use strings for file modes to preserve the leading 0s
- Add support the domain resolv.conf config option
- Add a gitignore and chefignore file
- Added a header to the resolv.conf file stating that chef edited the file
- Use the Ohai 'root_group' attribute for the config file to support non-Linux *nix platforms. This raises the minimum required version of Chef to 11.14.0 with Ohai 7.2.0.

## v1.2.0 (2014-10-16)

- [#11] Improve safety and sanity of cookbook
- [#12] README update
- [#14] Exclude search in template if attribute is empty

## v1.1.4

### Improvement

- **[COOK-3375](https://tickets.chef.io/browse/COOK-3375)** - Add Solaris support

## v1.1.2

### Bug

- [COOK-2977]: resolver cookbook has foodcritic failures

## v1.1.0

- [COOK-1242] - collect nameservers using a server role, adds `from_server_role` recipe

## v1.0.2

- 'node' went missing in the template.

## v1.0.0

- [COOK-1089] - accept resolver options via attributes
- [COOK-1109] - return from resolver recipe if no nameserver attribute is set so resolv.conf doesn't get broken during the run
- [COOK-1150] - drop the empty element from the nameserver attribute array
