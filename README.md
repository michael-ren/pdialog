# Pdialog

Pass-compatible dialog for passwords

## Installation

Pdialog requires GnuPG, `dialog`, and `coreutils`. 

Make `pdialog.sh` executable and optionally copy it to somewhere on `$PATH`, e.g. `/usr/local/bin/pdialog`.

## Running

If running from same directory:

    ./pdialog.sh

If copied onto `$PATH`:

    pdialog

This opens a dialog where you can select the password you want to view, displaying it in a pager. By default, the program will close after 30 seconds of inactivity.

Pdialog respects the `PASSWORD_STORE_DIR` environment variable, allowing you to override the default password directory, `~/.password-store`.

For convenience, you can bind the command to a keyboard shortcut such as `Super-D` to for example run:

    xfce4-terminal -e 'pdialog'
