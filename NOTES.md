There are some important things to note in order for these utilities to integrate and be used fully.

Namely:

- This is not to be considered a stable experience, but Gentoo should be bootstrappable from these utilities.
- Set your PATH and MANPATH as the package log asks (normally /usr/bsd/bin and /usr/bsd/share/man).
- Set POSIXLY_CORRECT=1 when using find(1), but setting it for other commands is fine too. This fixes etc-update and dispatch-conf.
- The kernel does compile, but only with the gentoo-kernel ebuild. Gentoo-sources has issues with bc due to nonstandard bc library usage.
- Some utilities will be slower. Namely, BSD grep is slower than GNU grep.
- At the current state, some file directories and options in the man pages may be incorrect when compared to the real programs. Please upstream the fixes to https://github.com/chimera-linux/chimerautils, or if it is Gentoo-specific, open a pull request!
