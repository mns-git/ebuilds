# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 savedconfig

DESCRIPTION="Suckless Status Tool"
HOMEPAGE="https://tools.suckless.org/slstatus/"
EGIT_REPO_URI="https://git.suckless.org/slstatus"
EGIT_COMMIT=c919def84fd4f52f501548e5f7705b9d56dd1459

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

pkg_postinst() {
  elog "Check ${HOMEPAGE} for more Details"
}