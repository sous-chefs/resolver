# resolver Cookbook CHANGELOG

This file is used to list changes made in each version of the resolver cookbook.

## 4.2.3 - *2025-09-04*

## 4.2.2 - *2024-05-02*

## 4.2.1 - *2024-05-02*

## 4.2.0 - *2024-01-29*

- Added support for sortlist option in resolv.conf
  
## 4.1.6 - *2023-12-21*

## 4.1.5 - *2023-10-03*

## 4.1.4 - *2023-09-29*

## 4.1.3 - *2023-05-17*

## 4.1.2 - *2023-05-04*

- chore(deps): update actions/checkout action to v3

## 4.1.1 - *2023-05-03*

- Update standardfiles

## 4.1.0 - *2022-08-08*

- Remove delivery and move to calling RSpec directly via a reusable workflow
- Add the `atomic_update` property
- Use MacOS 10.15 when using Vagrant testing
- Update Linux platforms for testing

## 4.0.3 - *2022-02-08*

- Remove delivery folder

## 4.0.2 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management

## 4.0.1 - *2021-06-01*

- Standardise files with files in sous-chefs/repo-management

## 4.0.0 - *2021-05-26*

- Switch to `unified_mode`
- Update `chef_version` to only support Chef 15.3 or later

## 3.0.4 - *2021-03-03*

- Fixed typo in the `CacheFromLocalhost` parameter in the systemd-resolved template

## 3.0.3 - *2021-02-25*

- Fix blog link for wrapper cookbooks

## 3.0.2 - *2021-02-25*

- Merge resolv.conf options & remove extra colons

## 3.0.1 - *2021-02-20*

- Update `Chef` -> `Chef Infra`

## 3.0.0 - *2021-02-18*

- Port recipes and attributes to resources
- Add support for overriding system configuration methods to resolver_config
- Add systemd-resolved support

## 2.2.0 - *2021-02-10*

- Sous Chefs Adoption
- Add InSpec Tests
- Remove Deprecated Platforms, Centos 6, Ubuntu 16.04, opensuse-42, fedora-29

## 2.1.0 (2018-07-18)

- Test with Local Delivery instead of Rake
- Update Apache license string in metadata
- the search stanza should be an array rather than a single element.  resolv.conf search allows up to six search domains to be defined.  Have updated the recipes with some rules (no more than 6 domains or 256 chars), change the ['resolver']['search'] into an array and changed teh template unless block to search for an empty array instead
- add aix support

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

- [COOK-3375] - Add Solaris support

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
