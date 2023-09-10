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
		openssl? ( dev-libs/openssl )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
	dev-util/meson
"

src_prepare() {
	default

}

src_configure() {
	local emesonargs=(
		$(meson_feature openssl)
		$(meson_feature minimal tiny)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	:
}
