# homebrew-mutt

Convenience repo with my customizations to the mutt formula for homebrew.

The following patches were added:

- [Sidebar](http://www.lunar-linux.org/mutt-sidebar/): enable with
  `--with-sidebar-patch`

- [Gmail Server Search](http://permalink.gmane.org/gmane.mail.mutt.devel/19624):
  enable with `--with-gmail-server-search-patch`

## How to install

If you had previously installed the default homebrew mutt, you must uninstall
that version first:

```
> brew uninstall mutt
```

Then proceed with installation based on custom formula:

```bash
> brew tap sgeb/mutt
# There will be a warning regarding overriding existing formula 'mutt'

> brew options sgeb/mutt/mutt
# List of available options

> brew install sgeb/mutt/mutt --with-sidebar-patch \
  --with-gmail-server-search-patch --with-trash-patch
# Compile and install customized mutt
```
