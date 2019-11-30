# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Howdy provides Windows Hello™ style authentication for Linux"
HOMEPAGE="https://github.com/boltgolt/howdy"
EGIT_REPO_URI="https://github.com/boltgolt/howdy.git"
SRC_URI="https://github.com/davisking/dlib-models/raw/master/dlib_face_recognition_resnet_model_v1.dat.bz2
        https://github.com/davisking/dlib-models/raw/master/mmod_human_face_detector.dat.bz2
        https://github.com/davisking/dlib-models/raw/master/shape_predictor_5_face_landmarks.dat.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/opencv
        sci-libs/dlib
        sci-libs/hdf5
        dev-python/click
        dev-python/numpy
        dev-python/pillow
        dev-python/pypam
        dev-python/sphinx
        "

RDEPEND="${DEPEND}"
BDEPEND=""

# JRG: Special version numbers to access specific branches. 
case "${PV}" in 
   # Head of master branch. This is a Gentoo convention. 
   9999) 
      ;; 
   # Normal tagged releases. 
   *) 
      REFS="refs/tags/v${PV}" 
      TAG="v${PV}" 
      ;; 
esac 

src_unpack() {
	git-r3_fetch "${EGIT_REPO_URI} ${REFS} ${TAG}"
	git-r3_checkout "${EGIT_REPO_URI} ${WORKDIR}/${P} ${TAG}"
   unpack ${A}
        mv *.dat ${S}/src/dlib-data
}

src_compile() { :; }

src_install() {
      keepdir   /lib/security/howdy/
      insinto   /lib/security/howdy/
      doins -r  src/* || die
      mkdir -p usr/bin
      fperms 755 /lib/security/howdy/cli.py
      dosym    ${D}/lib/security/howdy/cli.py usr/bin/howdy

}