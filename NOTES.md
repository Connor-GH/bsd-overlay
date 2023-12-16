There are some important things to note in order for these utilities to integrate and be used fully.

Namely:

- This is not to be considered a stable experience, but Gentoo should be bootstrappable from these utilities.
- Set your PATH and MANPATH as the package log asks (normally /opt/bsd/bin and /opt/bsd/share/man).
- Some utilities will be slower. Namely, BSD grep is slower than GNU grep.
- At the current state, some file directories and options in the man pages may be incorrect when compared to the real programs. Please upstream the fixes to https://github.com/chimera-linux/chimerautils, or if it is Gentoo-specific, open a pull request!
