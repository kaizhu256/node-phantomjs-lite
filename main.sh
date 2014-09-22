#!/bin/sh
shNpmInstall() {
  ## this funcition downloads and installs phantomjs and slimerjs
  NODEJS_PLATFORM=$(node -e "process.stdout.write(process.platform)") || return $?
  TMPDIR=$(node -e "process.stdout.write(require('os').tmpdir())") || return $?
  case $NODEJS_PLATFORM in
  darwin)
    if [ ! -f phantomjs ]
    then
      ## download phantomjs
      SCRIPT=":"
      SCRIPT="$SCRIPT && curl -3fLs -C - -o $TMPDIR/phantomjs-1.9.7-macosx.zip"
      SCRIPT="$SCRIPT https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-macosx.zip"
      ## install phantomjs
      SCRIPT="$SCRIPT; tar -xjf $TMPDIR/phantomjs-1.9.7-macosx.zip"
      SCRIPT="$SCRIPT && rm -f phantomjs && ln -s phantomjs-1.9.7-macosx/bin/phantomjs phantomjs"
      printf "$SCRIPT\n"
      eval "$SCRIPT" || return $?
    fi
    if [ ! -f slimerjs ]
    then
      ## download slimerjs
      SCRIPT=":"
      SCRIPT="$SCRIPT && curl -3fLs -C - -o $TMPDIR/slimerjs-0.9.3-mac.tar.bz2"
      SCRIPT="$SCRIPT http://download.slimerjs.org/releases/0.9.3/slimerjs-0.9.3-mac.tar.bz2"
      ## install slimerjs
      SCRIPT="$SCRIPT; tar -xjf $TMPDIR/slimerjs-0.9.3-mac.tar.bz2"
      SCRIPT="$SCRIPT && rm -f slimerjs && ln -s slimerjs-0.9.3/slimerjs slimerjs"
      printf "$SCRIPT\n"
      eval "$SCRIPT" || return $?
    fi
    ;;
  linux)
    if [ ! -f phantomjs ]
    then
      ## download phantomjs
      SCRIPT=":"
      SCRIPT="$SCRIPT && curl -3fLs -C - -o $TMPDIR/phantomjs-1.9.7-linux-x86_64.tar.bz2"
      SCRIPT="$SCRIPT https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2"
      ## install phantomjs
      SCRIPT="$SCRIPT; tar -xjf $TMPDIR/phantomjs-1.9.7-linux-x86_64.tar.bz2"
      SCRIPT="$SCRIPT && rm -f phantomjs && ln -s phantomjs-1.9.7-linux-x86_64/bin/phantomjs phantomjs"
      printf "$SCRIPT\n"
      eval "$SCRIPT" || return $?
    fi
    if [ ! -f slimerjs ]
    then
      ## download slimerjs
      SCRIPT=":"
      SCRIPT="$SCRIPT && curl -3fLs -C - -o $TMPDIR/slimerjs-0.9.3-linux-x86_64.tar.bz2"
      SCRIPT="$SCRIPT http://download.slimerjs.org/releases/0.9.3/slimerjs-0.9.3-linux-x86_64.tar.bz2"
      SCRIPT="$SCRIPT && rm -f slimerjs && ln -s slimerjs-0.9.3/slimerjs slimerjs"
      ## install slimerjs
      SCRIPT="$SCRIPT; tar -xjf $TMPDIR/slimerjs-0.9.3-linux-x86_64.tar.bz2"
      SCRIPT="$SCRIPT && rm -f slimerjs && ln -s slimerjs-0.9.3/slimerjs slimerjs"
      printf "$SCRIPT\n"
      eval "$SCRIPT" || return $?
    fi
    ;;
  esac
}

shNpmTest() {
  SCRIPT=":"
  SCRIPT="$SCRIPT && echo testing phantomjs && ./phantomjs main.js"
  SCRIPT="$SCRIPT && echo testing slimerjs && ./slimerjs main.js"
  printf "$SCRIPT\n"
  eval "$SCRIPT" || return $?
}

$@
