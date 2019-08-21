Sencha Cmd image
================

A basic docker image with preinstalled Sencha Cmd, nodejs and OpenJDK 8.

The images are tagged with the Sencha Cmd version.

Everything except the Sencha Cmd is installed via apt (and thus
available in the standard `$PATH`). Sencha Cmd is installed in
`/usr/local/Sencha/Cmd/$SENCHA_CMD_VERSION` and the executable is linked to `/usr/local/bin/sencha`.