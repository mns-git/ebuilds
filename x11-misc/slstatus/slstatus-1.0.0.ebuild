EAPI=7

inherit savedconfig

DESCRIPTION="slstatus"
HOMEPAGE="https://github.com/mns-git/slstatus"
SRC_URI="https://github.com/mns-git/${PN}/archive/refs/tags/${P}.tar.gz"

S="${WORKDIR}/${PN}-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE="savedconfig"

DOCS="LICENSE README"

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
BDEPEND=""

src_prepare() {
	default
	use savedconfig && restore_config config.h
}

src_install() {
	default
	use savedconfig && save_config config.h
}
