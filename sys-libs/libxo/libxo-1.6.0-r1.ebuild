# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A Library for Generating Text, XML, JSON, and HTML Output"
HOMEPAGE="https://juniper.github.io/libxo/libxo-manual.html"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Juniper/libxo.git"
else
	SRC_URI="https://github.com/Juniper/libxo/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2"
SLOT="0"

BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	eapply_user

	# sysctl.h isn't available anymore in glibc and the functionality was
	# removed from the linux kernel
	# https://sourceware.org/pipermail/glibc-cvs/2020q2/069366.html
	sed -i -e 's|#include <sys/sysctl.h>||' libxo/xo_syslog.c || die

	eautoreconf
}

src_test() {
	emake test
}
