#!/bin/sh

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

THEDIR=`pwd`
cd $srcdir

#AM_VERSION="1.11"
if ! type aclocal-$AM_VERSION 1>/dev/null 2>&1; then
	AUTOMAKE=automake
	ACLOCAL=aclocal
else
	ACLOCAL=aclocal-${AM_VERSION}
	AUTOMAKE=automake-${AM_VERSION}
fi

if test -f /opt/local/bin/glibtoolize ; then
	# darwin
	LIBTOOLIZE=/opt/local/bin/glibtoolize
elif test -f /usr/local/bin/glibtoolize ; then
	# also darwin
	LIBTOOLIZE=/usr/local/bin/glibtoolize
else
	LIBTOOLIZE=libtoolize
fi
if test -d /opt/local/share/aclocal ; then
	ACLOCAL_ARGS="-I /opt/local/share/aclocal"
fi

ln -s README.md README

echo "Generating build scripts for G729 codec..."
set -x
$LIBTOOLIZE --copy --force
$ACLOCAL  $ACLOCAL_ARGS
autoheader
$AUTOMAKE --force-missing --add-missing --copy
autoconf

cd $THEDIR

