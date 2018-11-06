#!/bin/sh

EXECDIR=$(cd "$(dirname "$0")" && pwd)
cd "$EXECDIR" || exit 1

PKGNAME=$(basename "$EXECDIR")

[ -z "$TOPDIR" ] && {
    TOPDIR="$HOME/rpmbuild"
}

for dir in SOURCES RPMS SRPMS BULID BUILDROOT SPECS
do
    mkdir -p "$TOPDIR/$dir"
done

SOURCEFILE="$TOPDIR/SOURCES/$PKGNAME.tar.gz"

cd ../ || exit 1
tar czvf "$SOURCEFILE" \
    --exclude rpmbuild \
    --exclude RPMS \
    --exclude .git \
    --exclude .gitignore \
    --exclude patch/unified_diff.patch \
    --exclude Makefile \
    --exclude documentation.list \
    "./$PKGNAME"
cd "$EXECDIR" || exit 1

rpmbuild -ba "rpm/$PKGNAME.spec" --target noarch

ls -l "$TOPDIR/RPMS/noarch"
ls -l "$TOPDIR/SRPMS"
