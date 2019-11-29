# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Clightd is a bus interface that lets you easily set screen brightness, gamma temperature and get ambient brightness through webcam frames capture or ALS devices."
HOMEPAGE="https://github.com/FedeDP/Clightd"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FedeDP/${PN}.git"
else
	SRC_URI="https://github.com/FedeDP/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="-* ~amd64"
fi

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-misc/ddcutil
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
		sys-auth/polkit
		>=sys-apps/systemd-221
		>=sys-power/libmodule-4.0.0
		dev-util/cmake
		dev-vcs/git"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
			-G "Unix Makefiles" \
        	-DCMAKE_INSTALL_PREFIX=/usr \
        	-DCMAKE_INSTALL_LIBDIR=lib \
        	-DCMAKE_BUILD_TYPE="Release" \
        	-DENABLE_DDC=1 -DENABLE_GAMMA=1 -DENABLE_IDLE=1 -DENABLE_DPMS=1 \
        	..
	)
	cmake-utils_src_configure
}