#!/bin/sh
shDownloadAndInstall() {
  # this funcition downloads and installs phantomjs and slimerjs
  if [ -f $FILE_LINK ]
  then
    return
  fi
  # download phantomjs
  SCRIPT="curl -#L -C - -o $FILE_TMP $FILE_URL"
  # install phantomjs
  SCRIPT="$SCRIPT; tar -xjf $FILE_TMP && rm -f $FILE_LINK && ln -s $FILE_BIN $FILE_LINK"
  printf "$SCRIPT\n"
  eval "$SCRIPT"
}

shNpmPostinstall() {
  # this function runs npm postinstall
  NODEJS_PLATFORM=$(node -e "process.stdout.write(process.platform)")
  TMPDIR=$(node -e "process.stdout.write(require('os').tmpdir())")
  case $NODEJS_PLATFORM in
  darwin)
    # download and install phantomjs
    FILE_BIN=phantomjs-1.9.7-macosx/bin/phantomjs
    FILE_LINK=phantomjs
    FILE_TMP=$TMPDIR/phantomjs-1.9.7-macosx.zip
    FILE_URL=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-macosx.zip
    shDownloadAndInstall
    # download and install slimerjs
    FILE_BIN=slimerjs-0.9.3/slimerjs
    FILE_LINK=slimerjs
    FILE_TMP=$TMPDIR/slimerjs-0.9.3-mac.tar.bz2
    FILE_URL=http://download.slimerjs.org/releases/0.9.3/slimerjs-0.9.3-mac.tar.bz2
    shDownloadAndInstall
    ;;
  linux)
    # download and install phantomjs
    FILE_BIN=phantomjs-1.9.7-linux-x86_64/bin/phantomjs
    FILE_LINK=phantomjs
    FILE_TMP=$TMPDIR/phantomjs-1.9.7-linux-x86_64.tar.bz2
    FILE_URL=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
    shDownloadAndInstall
    # download and install slimerjs
    FILE_BIN=slimerjs-0.9.3/slimerjs
    FILE_LINK=slimerjs
    FILE_TMP=$TMPDIR/slimerjs-0.9.3-linux-x86_64.tar.bz2
    FILE_URL=http://download.slimerjs.org/releases/0.9.3/slimerjs-0.9.3-linux-x86_64.tar.bz2
    shDownloadAndInstall
    ;;
  esac
}

shNpmTest() {
  printf '\ntesting phantomjs\n' && ./phantomjs test.js || return $?
  printf '\ntesting slimerjs\n' && ./slimerjs test.js || return $?
}

$@
