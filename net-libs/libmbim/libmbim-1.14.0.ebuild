# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit multilib

DESCRIPTION="Mobile Broadband Interface Model (MBIM) modem protocol helper library"
HOMEPAGE="https://cgit.freedesktop.org/libmbim/"
SRC_URI="https://www.freedesktop.org/software/libmbim/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~mips ppc x86"
IUSE="static-libs udev"

RDEPEND=">=dev-libs/glib-2.32:2
	udev? ( virtual/libgudev:= )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	virtual/pkgconfig"

PATCHES=( ${FILESDIR}/${P}-realpath.patch )

src_configure() {
	econf \
		--disable-more-warnings \
		--disable-gtk-doc \
		$(use_with udev) \
		$(use_enable static{-libs,})
}

src_install() {
	default
	use static-libs || rm -f "${ED}/usr/$(get_libdir)/${PN}-glib.la"
}
