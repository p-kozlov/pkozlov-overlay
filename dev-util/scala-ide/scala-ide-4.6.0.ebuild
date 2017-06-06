# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=5

inherit java-pkg-opt-2

# scala-ide -> scalaide
S_PACK="${PN/-/}-pack"

# scala-ide -> scala-SDK-${PV}
S_SDK="${PN%-*}-SDK-${PV}"

SRC_URI="http://downloads.typesafe.com/${S_PACK}/${PV}-vfinal-neon-212-20170516/${S_SDK}-vfinal-2.12-linux.gtk.x86_64.tar.gz"

DESCRIPTION="The Scala IDE"
HOMEPAGE="http://www.scala-ide.org"
KEYWORDS="~amd64"

SLOT="0"
LICENSE="BSD"

RDEPEND=">=virtual/jdk-1.8
	|| (
		dev-lang/scala
		dev-lang/scala-bin
	)
"

MY_D="/opt"

src_unpack() {
	default
	unpack ${A}
	mv "${WORKDIR}"/eclipse "${WORKDIR}"/"${P}"
}

src_prepare() {
	mv "${WORKDIR}"/"${P}"/eclipse "${WORKDIR}"/"${P}"/"${PN}"
}

src_install() {
	cd "${D}" || die
	dodir "${MY_D}" || die
	insinto "${MY_D}"
	doins -r "${WORKDIR}"/"${P}" || die
	insopts -m 0755
	insinto "${MY_D}"/"${P}"
	doins "${WORKDIR}"/"${P}"/"${PN}" || die
	dosym ${MY_D}/${P}/${PN} /usr/bin/${PN} || die
}

