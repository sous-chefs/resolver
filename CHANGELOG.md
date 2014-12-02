v1.2.0 (2014-10-16)
-------------------
- [#11] Improve safety and sanity of cookbook
- [#12] README update
- [#14] Exclude search in template if attribute is empty

v1.1.4
------
### Improvement
- **[COOK-3375](https://tickets.opscode.com/browse/COOK-3375)** - Add Solaris support

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
