#!/bin/sh
shDownloadAndInstall() {
  # this funcition downloads and installs phantomjs and slimerjs
  if [ ! -f $FILE_LINK ]
  then
    # download phantomjs
    if [ ! -f $FILE_TMP.downloaded ]
    then
      printf "downloading $FILE_URL\n" && curl -#L -C - -o $FILE_TMP $FILE_URL
      touch $FILE_TMP.downloaded
    fi
    # install phantomjs
    $FILE_UNZIP $FILE_TMP && rm -f $FILE_LINK && ln -s $FILE_BIN $FILE_LINK
  fi
}

shNpmPostinstall() {
  # this function runs npm postinstall
  TMPDIR=$(node -e "process.stdout.write(require('os').tmpdir())")
  case $(node -e "process.stdout.write(process.platform)") in
  darwin)
    # download and install phantomjs
    FILE_BIN=phantomjs-1.9.8-macosx/bin/phantomjs
    FILE_LINK=phantomjs
    FILE_TMP=$TMPDIR/phantomjs-1.9.8-macosx.zip
    FILE_URL=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-macosx.zip
    FILE_UNZIP="unzip -q"
    shDownloadAndInstall || return $?
    # download and install slimerjs
    FILE_BIN=slimerjs-0.9.3/slimerjs
    FILE_LINK=slimerjs
    FILE_TMP=$TMPDIR/slimerjs-0.9.3.zip
    FILE_URL=http://download.slimerjs.org/releases/0.9.3/slimerjs-0.9.3.zip
    FILE_UNZIP="unzip -q"
    shDownloadAndInstall || return $?
    ;;
  linux)
    # download and install phantomjs
    FILE_BIN=phantomjs-1.9.8-linux-x86_64/bin/phantomjs
    FILE_LINK=phantomjs
    FILE_TMP=$TMPDIR/phantomjs-1.9.8-linux-x86_64.tar.bz2
    FILE_URL=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
    FILE_UNZIP="tar -xjf"
    shDownloadAndInstall || return $?
    # download and install slimerjs
    FILE_BIN=slimerjs-0.9.3/slimerjs
    FILE_LINK=slimerjs
    FILE_TMP=$TMPDIR/slimerjs-0.9.3.tar.bz2
    FILE_URL=https://kaizhu256.github.io/node-phantomjs-lite/slimerjs-0.9.3.tar.bz2
    FILE_UNZIP="tar -xjf"
    shDownloadAndInstall || return $?
    ;;
  esac
}

shNpmTest() {
  # this function runs npm test
  printf '\ntesting phantomjs\n' && ./phantomjs test.js || return $?
  printf '\ntesting slimerjs\n' && ./slimerjs test.js || return $?
}

shNpmTestPublished() {
  # this function runs npm test on the current published package
  cd /tmp && rm -fr /tmp/node_modules && npm install $PACKAGE_JSON_NAME || return $?
  cd /tmp/node_modules/$PACKAGE_JSON_NAME && npm test || return $?
}

shMain() {
  # this function is the main program and parses argv
  # init $CWD
  CWD=$(pwd) || return $?
  # init $PACKAGE_JSON_*
  eval $(node -e "var dict, value;\
    dict = require('./package.json');
    console.log(Object.keys(dict).map(function (key) {\
      value = dict[key];\
      return typeof value === 'string' ?\
        'export PACKAGE_JSON_' + key.toUpperCase() + '=' + JSON.stringify(value.split('\n')[0])\
        : ':';\
    }).join(';'))") || return $?
  # eval argv
  $@
  # init $EXIT_CODE
  local EXIT_CODE=$? || return $?
  # restore $CWD
  cd $CWD || return $?
  # return $EXIT_CODE
  return $EXIT_CODE
}
# init main routine
shMain $@
