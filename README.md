# homebrew-mutt

Convenience repo with my customizations to the mutt formula for homebrew.

The following patches were added:

- [Sidebar](https://github.com/sgeb/homebrew-mutt/blob/master/patches/mutt-sidebar.patch):
  enable with `--with-sidebar-patch`.
  [[Source](http://www.lunar-linux.org/mutt-sidebar/)]

- [Gmail Server
  Search](https://github.com/sgeb/homebrew-mutt/blob/master/patches/patch-mutt-gmailcustomsearch.v1.patch):
  enable with `--with-gmail-server-search-patch`. Note that Gmail Server Search
  only works when directly connected to Gmail via IMAP.
  [[Source](http://permalink.gmane.org/gmane.mail.mutt.devel/19624)]

- [Gmail
  Labels](https://github.com/sgeb/homebrew-mutt/blob/master/patches/mutt-1.5.23-gmail-labels.sgeb.v1.patch):
  enable with `--with-gmail-labels-patch`. Originally based on [a
  patch](https://www.mail-archive.com/mutt-dev@mutt.org/msg07593.html) by Todd
  Hoffmann. Add `%?y?(%y)?` to your `index_format` to conditionally display the
  associated labels and make sure to disable `header_cache`. Labels 'Important'
  and 'Starred' are stripped from the list of labels. Note that Gmail Labels
  only work when directly connected to Gmail via IMAP.

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

> brew install sgeb/mutt/mutt --with-trash-patch \
  --with-sidebar-patch --with-gmail-server-search-patch \
  --with-trash-patch --with-gmail-labels-patch
# Compile and install customized mutt
```
