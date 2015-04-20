v1.3.0 (2015-10-16)
-------------------
- Add rubocop file and resolve all rubocop warnings
- Update the contributing doc to match the new process
- Use strings for file modes to preserve the leading 0s
- Add support the domain resolv.conf config option
- Add a gitignore and chefignore file
- Added a header to the resolv.conf file stating that chef edited the file
- Use the Ohai 'root_group' attribute for the config file to support non-Linux *nix platforms.  This raises the minimum required version of Chef to 11.14.0 with Ohai 7.2.0.

v1.2.0 (2014-10-16)
-------------------
- [#11] Improve safety and sanity of cookbook
- [#12] README update
- [#14] Exclude search in template if attribute is empty

v1.1.4
------
### Improvement
- **[COOK-3375](https://tickets.chef.io/browse/COOK-3375)** - Add Solaris support

v1.1.2
------
### Bug
- [COOK-2977]: resolver cookbook has foodcritic failures

v1.1.0
------
- [COOK-1242] - collect nameservers using a server role, adds `from_server_role` recipe

v1.0.2
------
- 'node' went missing in the template.

v1.0.0
------
- [COOK-1089] - accept resolver options via attributes
- [COOK-1109] - return from resolver recipe if no nameserver attribute is set so resolv.conf doesn't get broken during the run
- [COOK-1150] - drop the empty element from the nameserver attribute array
