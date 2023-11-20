# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Chimera's core userland, based on FreeBSD"
HOMEPAGE="https://chimera-linux.org"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chimera-linux/chimerautils.git"
else
	SRC_URI="https://github.com/chimera-linux/chimerautils/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"

IUSE="+bzip2 +libedit +lzma +openssl +terminfo tiny +zlib"

# No tests
RESTRICT="test"

RDEPEND="
	sys-apps/acl
	sys-libs/libxo
	bzip2? ( app-arch/bzip2 )
	libedit? ( dev-libs/libedit )
	lzma? ( app-arch/xz-utils )
	openssl? ( dev-libs/openssl:= )
	terminfo? ( sys-libs/ncurses:= )
	zlib? ( sys-libs/zlib )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	app-alternatives/lex
	app-alternatives/yacc
	virtual/pkgconfig
"

src_prepare() {
	local PATCHES=(
		"${FILESDIR}"/*.patch
	)
	default
	eapply_user

	export BSD_PREFIX="${EPREFIX}/opt/bsd"

	# Just not use BSD bc. It ends up
	# being more trouble than it's worth, plus
	# there is an app-alternatives/bc[gh]
	sed -i -e "s|subdir('bc')||g" src.freebsd/bc/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature bzip2)
		$(meson_feature libedit)
		$(meson_feature lzma)
		$(meson_feature openssl)
		$(meson_feature tiny)
		$(meson_feature zlib)
		$(meson_use terminfo color_ls)
		--prefix=${BSD_PREFIX}
	)

	meson_src_configure
}

pkg_postinst() {
	elog "Add \"${BSD_PREFIX}/bin\" to \$PATH and add \"${BSD_PREFIX}/share/man\" to \$MANPATH"
}
