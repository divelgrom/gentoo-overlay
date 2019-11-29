# Copyright 1999-2018 Gentoo Foundation 
# Distributed under the terms of the GNU General Public License v3 


EAPI=6 


DESCRIPTION="Firmware for Killer Wireless-AC 1535 Network WiFi devices" 
HOMEPAGE="https://www.killernetworking.com" 
SRC_URI="https://www.killernetworking.com/support/K1535_Debian/board.bin
            https://www.killernetworking.com/support/K1535_Debian/firmware-4.bin " 

LICENSE="Proprietary"
SLOT="0" 
KEYWORDS="~amd64 ~x86 amd64 x86" 
IUSE="" 

DEPEND="" 
RDEPEND="" 

pkg_pretend() {
	if use kernel_linux ; then
		if [[ -e "${ROOT}"/usr/src/linux/.config ]] ; then
			if kernel_is lt 2 6 30 ; then
				CONFIG_CHECK="ATH10K_PCI"
				ERROR_ATH10K_PCI="ATH10K_PCI not found in kernel. Pls configure!!! "
				check_extra_config
			fi
		fi
	fi
}

src_unpack() { 
    mkdir -p $WORKDIR/$P || die
	cp $DISTDIR/* $WORKDIR/$P || die
} 

src_compile() { :; } 

src_install() { 
    insinto /lib/firmware/ath10k/QCA6174/hw3.0/
    doins board.bin firmware-4.bin || die
}