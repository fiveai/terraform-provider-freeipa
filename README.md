# terraform-provider-freeipa

## Build

Makefile has been made basically and will attempt to crosscompile for all distros. Due to kerberos and
using a non-native (no golang) library this requires gcc compiler which breaks very easy across the
distributions so your probably end up with failures.

TODO: separate make tasks to specify distro on build for local

```bash
make dist
```
