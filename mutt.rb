require 'formula'

class Mutt < Formula
  desc "Mongrel of mail user agents (part elm, pine, mush, mh, etc.)"
  homepage 'http://www.mutt.org/'
  url "https://bitbucket.org/mutt/mutt/downloads/mutt-1.6.1.tar.gz"
  mirror "ftp://ftp.mutt.org/pub/mutt/mutt-1.6.1.tar.gz"
  sha256 "98b26cecc6b1713082fc880344fa345c20bd7ded6459abe18c84429c7cf8ed20"

  head do
    url 'https://dev.mutt.org/hg/mutt#default', :using => :hg

    resource 'html' do
      url 'https://dev.mutt.org/doc/manual.html', :using => :nounzip
    end
  end

  conflicts_with "tin",
    :because => "both install mmdf.5 and mbox.5 man pages"

  option "with-debug", "Build with debug option enabled"
  option "with-s-lang", "Build against slang instead of ncurses"
  option "with-confirm-attachment-patch", "Apply confirm attachment patch"

  # start - customizations for sgeb/mutt
  option "with-trash-patch", "Apply trash folder patch"
  option "with-ignore-thread-patch", "Apply ignore-thread patch"
  option "with-pgp-verbose-mime-patch", "Apply PGP verbose mime patch"
  option "with-sidebar-patch", "Apply sidebar patch"
  option "with-gmail-server-search-patch", "Apply gmail server search patch"
  option "with-gmail-labels-patch", "Apply gmail labels patch"
  option "with-forwref-patch", "Apply forward_references patch"
  # end - customizations for sgeb/mutt

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  depends_on "openssl"
  depends_on "tokyo-cabinet"
  depends_on "gettext" => :optional
  depends_on "gpgme" => :optional
  depends_on "libidn" => :optional
  depends_on "s-lang" => :optional

  if build.with? "confirm-attachment-patch"
    patch do
      # source: https://gist.githubusercontent.com/tlvince/5741641/raw/c926ca307dc97727c2bd88a84dcb0d7ac3bb4bf5/mutt-attach.patch
      url "https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/mutt-attach.patch"
      sha256 "da2c9e54a5426019b84837faef18cc51e174108f07dc7ec15968ca732880cb14"
    end
  end

  # start - customizations for sgeb/mutt

  if build.with? "trash-patch"
    patch do
      # source: http://ftp.openbsd.org/pub/OpenBSD/distfiles/mutt/trashfolder-1.6.0.diff.gz
      url "https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/trashfolder-1.6.0.diff.gz"
      sha256 "b779c6df61a77f3069139aad8562b4a47c8eed8ab5b8f5681742a1c2eaa190b8"
    end
  end

  # original source for this went missing, patch sourced from Arch at
  # https://aur.archlinux.org/packages/mutt-ignore-thread/
  # slightly adjusted to match v1.6.1
  if build.with? "ignore-thread-patch"
    patch do
      url "https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/mutt-1.6.1-ignore-thread.patch"
      sha256 "c9dbfdd96d363df663fef4ae8ae88f576e69fe669a6d96f9a674411df9378c93"
    end
  end

  if build.with? "pgp-verbose-mime-patch"
    patch do
      # source: https://sourceforge.net/p/gentoomuttpatches/code/ci/default/tree/13-pgp-verbose-mime.patch?format=raw
      # slightly adjusted to match v1.6.1
      url "https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/13-pgp-verbose-mime.patch"
      sha256 "ef9c19d4115a4d4a95af5a78cac2d7788592edc547e1fd9b0fe40f4ab04e1698"
    end
  end

  if build.with? "sidebar-patch"
    patch do
      # source: http://ftp.openbsd.org/pub/OpenBSD/distfiles/mutt/sidebar-1.6.0.diff.gz
      url "https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/sidebar-1.6.0.diff.gz"
      sha256 "63b6b28d7008b6d52bd98151547b052251cd4bc87e467e47ffebe372dfe7155b"
    end
  end

  if build.with? "gmail-server-search-patch"
    patch do
      url "https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/mutt-1.6.1-gmailcustomsearch.patch"
      sha256 "79844d521eb9d426cff4be44cc4a09575f3efa257019fb27aa3275a7389e9279"
    end
  end

  if build.with? "gmail-labels-patch"
    patch do
      url "https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/mutt-1.5.23-gmail-labels.sgeb.v1.patch"
      sha256 "2b80584e0e799d798f250f6559d6f9bb517ac4a7c47e739318eb8263c8f67a7c"
    end
  end

  if build.with? "gmail-forwref-patch"
    patch do
      url "https://raw.githubusercontent.com/sgeb/homebrew-mutt/master/patches/mutt-1.7.1-forwref.sgeb.patch"
      sha256 "b731ac9859befbf83bc902d909b722f3c8a2b17cd5200982b5479c364b4942b8"
    end
  end

  # end - customizations for sgeb/mutt

  def install
    user_admin = Etc.getgrnam("admin").mem.include?(ENV["USER"])

    args = %W[
      --disable-dependency-tracking
      --disable-warnings
      --prefix=#{prefix}
      --with-ssl=#{Formula["openssl"].opt_prefix}
      --with-sasl
      --with-gss
      --enable-imap
      --enable-smtp
      --enable-pop
      --enable-hcache
      --with-tokyocabinet
      ]

      # This is just a trick to keep 'make install' from trying
      # to chgrp the mutt_dotlock file (which we can't do if
      # we're running as an unprivileged user)
      args << "--with-homespool=.mbox" unless user_admin

      args << "--disable-nls" if build.without? "gettext"
      args << "--enable-gpgme" if build.with? "gpgme"
      args << "--with-slang" if build.with? "s-lang"

      if build.with? "debug"
        args << "--enable-debug"
      else
        args << "--disable-debug"
      end

      system "./prepare", *args
      system "make"

      # This permits the `mutt_dotlock` file to be installed under a group
      # that isn't `mail`.
      # https://github.com/Homebrew/homebrew/issues/45400
      if user_admin
        inreplace "Makefile", /^DOTLOCK_GROUP =.*$/, "DOTLOCK_GROUP = admin"
      end

      system "make", "install"
      doc.install resource("html") if build.head?
  end

  test do
    system bin/"mutt", "-D"
  end
end
