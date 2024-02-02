# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 savedconfig check-reqs

DESCRIPTION="Suckless Status Tool"
HOMEPAGE="https://tools.suckless.org/slstatus/"

EGIT_REPO_URI="https://git.suckless.org/slstatus"
EGIT_COMMIT=f68f49273e70b3767b30c549dda04ddd4d25fc91

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 ~amd64"
IUSE="savedconfig"

DOCS="LICENSE README"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-base/xorg-proto
"

check_req() {
	local CHECKREQS_DISK_BUILD="1M"
	local CHECKREQS_DISK_USR="1M"
	local CHECKREQS_MEMORY="2G"
	check-reqs_${EBUILD_PHASE_FUNC}
}

pkg_pretend() {
	check_req
}

pkg_setup() {
	check_req
}

src_prepare() {
	default

	sed -i \
		-e "s/ -Os / /" \
		-e "/^PREFIX/{s:/usr/local:/usr:}" \
		-e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/{s| = | += |g;s|-s ||g}" \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir):}" \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die

	use savedconfig && restore_config config.h
}

src_install() {
	default
	dodoc README
	use savedconfig && save_config config.h
}

pkg_postinst() {
  einfo "Check ${HOMEPAGE} for more Details"
}
