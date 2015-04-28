#!/bin/bash -e

GH_REF=github.com/killbill/killbill-docs.git
BUILD=`mktemp -d "${TMPDIR:-/tmp}"/foo.XXXX`

cp -r build $BUILD

pushd $BUILD
git clone --depth=5 --branch=gh-pages git://$GH_REF
popd

mv -f $BUILD/build/selfcontained/* $BUILD/killbill-docs/latest/

pushd $BUILD/killbill-docs
git config user.name "Travis-CI"
git config user.email "travis@killbill.io"
git add `readlink latest`
git commit -m "Docs update"
git push -fq "https://${GH_TOKEN}@${GH_REF}" gh-pages:gh-pages > /dev/null 2>&1
popd
