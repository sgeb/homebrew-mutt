# homebrew-mutt

Convenience repo with my customizations to the mutt formula for homebrew.

The following patches were added:

- [Sidebar](http://www.lunar-linux.org/mutt-sidebar/): enable with
  `--with-sidebar-patch`

- [Gmail Server Search](http://permalink.gmane.org/gmane.mail.mutt.devel/19624):
  enable with `--with-gmail-server-search-patch`. Note that Gmail Server Search
  only works when directly connected to Gmail via IMAP.

- [Gmail Labels](http://marc.info/?l=mutt-dev&m=132782593823479&w=2):
  enable with `--with-gmail-labels-patch`. I've pulled this out of the mutt dev
  mailing list. The original patch was created by Todd Hoffmann. Add `%?y?(%y)?`
  in your `index_format` to conditionally display the associated labels and make
  sure to disable `header_cache`. Note that Gmail Labels only work when directly
  connected to Gmail via IMAP.

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
