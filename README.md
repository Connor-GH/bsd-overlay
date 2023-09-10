With this overlay, you should now be able to install chimautils (https://github.com/chimera-linux/chimerautils) through Gentoo's Portage package manager.

You can add the repository with ``eselect repository add bsd-overlay git https://github.com/connor-gh/bsd-overlay.git``

You then sync with ``emaint sync -r bsd-overlay``

After accepting your respective keyword, you can install it with a basic ``emerge --ask sys-apps/chimerautils``.
