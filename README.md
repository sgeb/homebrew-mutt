# homebrew-mutt

[![Build
Status](https://travis-ci.org/sgeb/homebrew-mutt.svg?branch=master)](https://travis-ci.org/sgeb/homebrew-mutt)

Homebrew formula with additional patches for mutt.

Some of the additional patches (refer to [formula](https://github.com/sgeb/homebrew-mutt/blob/master/mutt.rb) for the complete list):

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

- [Forward
  References](https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/mutt-1.7.1-forwref.sgeb.patch):
  enable with `--with-forwref-patch`. When set, forwarded messages set the
  `In-Reply-To:` and `References:` headers in the same way as normal replies
  would. It effectively includes forwarded messages as part of the original
  thread.

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
# Note that not all combinations are always possible (due to potentially
# conflicting patches).

--with-confirm-attachment-patch
        Apply confirm attachment patch
--with-debug
        Build with debug option enabled
--with-forwref-patch
        Apply forward_references patch
--with-gmail-labels-patch
        Apply gmail labels patch
--with-gmail-server-search-patch
        Apply gmail server search patch
--with-gpgme
        Build with gpgme support
--with-ignore-thread-patch
        Apply ignore-thread patch
--with-pgp-verbose-mime-patch
        Apply PGP verbose mime patch
--with-s-lang
        Build against slang instead of ncurses
--with-sidebar-patch
        Apply sidebar patch
--with-trash-patch
        Apply trash folder patch
--HEAD
        Install HEAD version

> brew install sgeb/mutt/mutt --with-trash-patch \
  --with-sidebar-patch --with-gmail-server-search-patch \
  --with-gmail-labels-patch --with-forwref-patch
# Compile and install customized mutt.
# This is an example, refer to the command above to see the
# available options.
```
