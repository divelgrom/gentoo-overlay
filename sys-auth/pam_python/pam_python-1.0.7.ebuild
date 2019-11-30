# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit python-any-r1 pam

MY_PN="pam-python"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Allows PAM modules to be written in Python"
HOMEPAGE="https://sourceforge.net/projects/pam-python/"
SRC_URI="https://excellmedia.dl.sourceforge.net/project/pam-python/${MY_P}-1/${MY_P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND=">=sys-libs/pam-0.76"
DEPEND=">=sys-libs/pam-0.76
		doc? ( dev-python/sphinx )"

# this litle crutch, doc not function
src_compile() {
	if use doc; then
		TARGET="lib"
	else
		TARGET="lib"
	fi
	emake "${TARGET}" || die
}

src_install() {
	dopammod src/build/lib.*/pam_python.so

	dodoc ChangeLog.txt README.txt

	if use doc; then
		dohtml -r doc/html/*
	fi
}

src_test() {
	# FIXME
	true
}