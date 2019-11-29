# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="eXtensible UPnP agent v.2"
HOMEPAGE="http://xupnpd.org/xupnpd2_ru.html"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/clark15b/${PN}.git"
else
	SRC_URI="https://github.com/clark15b/${PN}2/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="-* ~amd64"
fi

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/make"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin hello-world
}
