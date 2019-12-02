# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SERVICE="corefreqd"

DESCRIPTION="CoreFreq is a CPU monitoring software designed for the 64-bits Processors."
HOMEPAGE="https://github.com/cyring/CoreFreq"

if [ ${PV} == "9999" ] ; then
	inherit git-r3 autotools linux-info linux-mod systemd
	EGIT_REPO_URI="https://github.com/cyring/CoreFreq.git"
else
	SRC_URI=""
	KEYWORDS="-* ~amd64"
fi

LICENSE="GNU General Public License v2.0" 
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/make
        kernel_linux? ( virtual/linux-sources )"
RDEPEND="${DEPEND}"
BDEPEND=""

MODULE_NAMES="corefreqk"

src_configure() {
    set_arch_to_kernel
}

src_compile() {
    emake -j1 all || die
}

src_install() {
    keepdir /lib/modules/${KV_FULL}/extra/
    insinto /lib/modules/${KV_FULL}/extra/
    doins corefreqk.ko
    into /
	dobin corefreqd corefreq-cli || die
    systemd_newunit ${SERVICE}.service ${SERVICE}.service
}