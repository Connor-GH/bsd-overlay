# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION=""
HOMEPAGE="https://juniper.github.io/libxo/libxo-manual.html"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Juniper/${PN}.git"
else
	SRC_URI="https://github.com/Juniper/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~ppc64"
fi

IUSE="test"
LICENSE="BSD-2"
SLOT="0"
RDEPEND=""
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
	sys-devel/autoconf
"

src_prepare() {
	default
	sed -e 's|#include <sys/sysctl.h>||g' -i libxo/xo_syslog.c || die
	eautoreconf
}

src_configure() {
	default
}

src_compile() {
	# cd build
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	:
}
