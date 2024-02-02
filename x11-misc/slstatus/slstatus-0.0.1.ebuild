# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig

DESCRIPTION="slstatus"
HOMEPAGE="https://github.com/mns-git/slstatus"
SRC_URI="https://github.com/mns-git/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE="savedconfig"

DOCS="LICENSE README"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-base/xorg-proto
"
BDEPEND=""

src_prepare() {
	default
	use savedconfig && restore_config config.h
}

src_install() {
	default
	dodoc README
	use savedconfig && save_config config.h
}
