# NadirRemote

NadirRemote is an independently modified Windows distribution of RustDesk.
It is not an official RustDesk release and is not endorsed by the RustDesk developers.

Brand customisation prepared for Nadir on 2026-10-28. See provenance.json for the
exact upstream and hbb_common commits. Upstream authors and copyright notices are
retained. This derivative is distributed under GNU AGPL version 3; see LICENCE.
The original RustDesk engine, protocols, codecs and security mechanisms remain
upstream code. This does not transfer ownership of RustDesk to Nadir.

Changes: Windows runtime app name; Windows product metadata; logo and icons;
About attribution and a bundled-source link; a Windows-only manual build workflow;
an optional visible installer helper that verifies automatic service startup.

The complete reviewed source snapshot and build instructions are bundled in
source.zip alongside the Windows executable. The About page opens that local
archive. Distribute this archive and upstream notices together with the binary.
Dependency manifests and lockfiles retain the source locations of dependencies.
Dependencies and optional bundled drivers retain their respective licenses.

The stock public rendezvous/relay configuration is unchanged. Public RustDesk
infrastructure is operated by third parties and is not a NadirRemote service.
Availability for modified clients is not guaranteed by this project. No private
server, credentials, certificate, permanent password or vendor subscription is
included. Setup of a permanent access password is done by the device owner.

No official RustDesk signing keys, commercial branding configuration, paid API,
or licensing mechanism have been bypassed. Branding is implemented in source.
The build is unsigned unless the distributor separately signs it.
