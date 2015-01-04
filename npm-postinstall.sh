#!/bin/sh
shDownloadAndInstall() {
  # this function downloads and installs phantomjs and slimerjs
  if [ -f $FILE_LINK ] || ([ "$FILE_UNZIP" = "unzip -q" ] && ! (unzip > /dev/null 2>&1))
  then
    return
  fi
  # download phantomjs
  if [ ! -f $FILE_TMP.downloaded ]
  then
    printf "downloading $FILE_URL to $FILE_TMP\n" || return $?
    mkdir -p $TMPDIR2 && curl -#L -C - -o $FILE_TMP $FILE_URL || return $?
    touch $FILE_TMP.downloaded || return $?
  fi
  # install phantomjs
  $FILE_UNZIP $FILE_TMP && rm -f $FILE_LINK && ln -s $FILE_BIN $FILE_LINK
}

shNpmPostinstall() {
  # this function runs npm postinstall
  TMPDIR2=/tmp/$USER
  case $(uname) in
  Darwin)
    # download and install phantomjs
    FILE_BIN=phantomjs-1.9.8-macosx/bin/phantomjs
    FILE_LINK=phantomjs
    FILE_TMP=$TMPDIR2/phantomjs-1.9.8-macosx.zip
    FILE_URL=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-macosx.zip
    FILE_UNZIP="unzip -q"
    shDownloadAndInstall || return $?
    # download and install slimerjs
    FILE_BIN=slimerjs-0.9.4/slimerjs
    FILE_LINK=slimerjs
    FILE_TMP=$TMPDIR2/slimerjs-0.9.4.zip
    FILE_URL=http://download.slimerjs.org/releases/0.9.4/slimerjs-0.9.4.zip
    FILE_UNZIP="unzip -q"
    shDownloadAndInstall || return $?
    ;;
  Linux)
    # download and install phantomjs
    FILE_BIN=phantomjs-1.9.8-linux-x86_64/bin/phantomjs
    FILE_LINK=phantomjs
    FILE_TMP=$TMPDIR2/phantomjs-1.9.8-linux-x86_64.tar.bz2
    FILE_URL=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
    FILE_UNZIP="tar -xjf"
    shDownloadAndInstall || return $?
    # download and install slimerjs
    FILE_BIN=slimerjs-0.9.4/slimerjs
    FILE_LINK=slimerjs
    FILE_TMP=$TMPDIR2/slimerjs-0.9.4.zip
    FILE_URL=http://download.slimerjs.org/releases/0.9.4/slimerjs-0.9.4.zip
    FILE_UNZIP="unzip -q"
    shDownloadAndInstall || return $?
    ;;
  esac
}

# run npm postinstall
shNpmPostinstall
