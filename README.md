phantomjs-lite [![NPM](https://img.shields.io/npm/v/phantomjs-lite.svg?style=flat-square)](https://www.npmjs.org/package/phantomjs-lite) [![travis.ci-org build status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)
==============
minimal npm installer for phantomjs and slimerjs binaries with no external dependencies



# build info [![travis-ci.org build status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)
```
# build-ci.sh
# this shell code runs the ci-build process
shBuildCi() {
  # init env
  . utility2 && shInit && mkdir -p .tmp/build/coverage-report.html || return $?
  # test quickstart
  MODE_CI_BUILD=testQuickstartSh shRunScreenshot shTestQuickstartSh || return $?
  # test example code
  MODE_CI_BUILD=testExampleJs shRunScreenshot shTestExampleJs || return $?
  # npm test
  MODE_CI_BUILD=npmTest shRunScreenshot npm test || return $?
}
# run build process in ci env
shBuildCi
# save exit code
EXITCODE=$?
# upload build artifacts to github
if [ "$TRAVIS" ]
then
  shRun shBuildGithubUpload || exit $?
fi
# exit with $EXIT_CODE
exit $EXIT_CODE
```



## quickstart
```
# quickstart.sh
# this shell code runs the quickstart demo
# 1. create a clean app directory (e.g /tmp/app)
# 2. inside app directory, run the following shell code inside a terminal

shQuickstartSh() {
  # install phantomjs and slimerjs into ./node_modules/phantomjs-lite
  npm install phantomjs-lite || return $?

  # end interactive phantomjs session after 10 seconds
  /bin/sh -c "sleep 10 && killall phantomjs" &

  # start interactive phantomjs session
  ./node_modules/phantomjs-lite/phantomjs

  # reset terminal settings in case it gets mangled by phantomjs
  stty sane || return $?
}

# run quickstart demo
shQuickstartSh
```
#### output
[![screenshot](https://kaizhu256.github.io/node-phantomjs-lite/screenshot.testQuickstartSh.png)](https://kaizhu256.github.io/node-phantomjs-lite/screenshot.testQuickstartSh.png)



## nodejs example code
```
// example.js
// this nodejs code spawns a phantomjs process to run the phantomjs-lite test.js script
// 1. create a clean app directory (e.g /tmp/app)
// 2. inside app directory, save this js code as example.js
// 3. inside app directory, run the following shell command:
//    $ npm install phantomjs-lite && node example.js
/*jslint
  indent: 2,
  node: true, nomen: true
*/
(function $$example() {
  'use strict';
  // require phantomjs-lite
  var phantomjs_lite = require('phantomjs-lite');
  // spawn phantomjs child-process to run phantomjs-lite/test.js
  require('child_process').spawn(
    phantomjs_lite.__dirname + '/phantomjs',
    [ phantomjs_lite.__dirname + '/test.js' ],
    { stdio: 'inherit' }
  // pass phantomjs child-process's exit-code to this process
  ).on('exit', process.exit);
}());
```
#### output
[![screenshot](https://kaizhu256.github.io/node-phantomjs-lite/screenshot.testExampleJs.png)](https://kaizhu256.github.io/node-phantomjs-lite/screenshot.testExampleJs.png)



## npm dependencies
- none



## package content
- .gitignore
  - git ignore file
- .travis.yml
  - travis-ci config file
- README.md
  - readme file
- index.js
  - main nodejs app
- npm-postinstall.sh
  - npm postinstall shell script
- package.json
  - npm config file
- test.js
  - phantomjs test script



## changelog
#### todo
- add screen-capture example
- none

#### 2015.1.x
- automate build with utility2
- update README.md

#### 2014.10.31
- remove dependency on https://kaizhu256.github.io/node-phantomjs-lite/slimerjs-0.9.3.tar.bz2
- bump slimerjs to 0.9.4
- rename cli.sh to npm-postinstall.sh
- remove 'unzip' dependency for installing slimerjs on linux systems
- use lightweight version of slimerjs
- better cache file download
- rename headless-browser-lite to phantomjs-lite
- split main.js into index.js and test.js

#### 2014.9.22
- add README.md
- initial package creation
