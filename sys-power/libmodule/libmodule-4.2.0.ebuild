# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Libmodule offers a small and simple C implementation of an actor library that aims to let developers easily create modular C projects in a way which is both simple and elegant."
HOMEPAGE="https://github.com/FedeDP/libmodule"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FedeDP/${PN}.git"
else
	SRC_URI="https://github.com/FedeDP/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="-* ~amd64"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/cmake
		dev-vcs/git"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	cmake-utils_src_configure
	}