# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs meson

DESCRIPTION=""
HOMEPAGE="https://chimera-linux.org"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chimera-linux/${PN}.git"
else
	SRC_URI="https://github.com/chimera-linux/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~ppc64"
fi

IUSE="+openssl minimal"
LICENSE="BSD"
SLOT="0"
RDEPEND="
		sys-libs/libxo
		dev-libs/libedit
		sys-apps/acl
		openssl? ( dev-libs/openssl )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
	dev-util/meson
"

PATCHES=(
	"${FILESDIR}/${P}-find-POSIXLY_CORRECT.patch"
)
src_prepare() {
	default

}

BSD_PREFIX="/usr/bsd"

src_configure() {
	local emesonargs=(
		$(meson_feature openssl)
		$(meson_feature minimal tiny)
	)
	meson_src_configure --prefix=${BSD_PREFIX}
	sed -i -e "s|/usr/bin/dc|${BSD_PREFIX}/bin/dc|g" src.freebsd/bc/bc/pathnames.h
	sed -i -e "s|/usr/share/misc/bc.library|${BSD_PREFIX}/share/misc/bc.library|g" src.freebsd/bc/bc/pathnames.h
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	elog "Add \"${BSD_PREFIX}/bin\" to \$PATH and add \"${BSD_PREFIX}/share/man\" to \$MANPATH"
}
