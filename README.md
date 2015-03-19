phantomjs-lite [![NPM](https://img.shields.io/npm/v/phantomjs-lite.svg?style=flat-square)](https://www.npmjs.org/package/phantomjs-lite) [![travis.ci-org build status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)
==============
minimal npm installer for phantomjs and slimerjs binaries with zero external dependencies



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



# npm-dependencies
- [istanbul-lite](https://www.npmjs.com/package/istanbul-lite)
- [jslint-lite](https://www.npmjs.com/package/jslint-lite)



# package-listing
[![screen-capture](https://kaizhu256.github.io/node-utility2/build/screen-capture.gitLsTree.png)](https://github.com/kaizhu256/node-utility2)



# package.json
```
{
    "_packageJson": true,
    "description": "minimal npm installer for phantomjs and slimerjs binaries with zero external dependencies",
    "devDependencies": {
        "utility2": "2015.3.19-11"
    },
    "engines": { "node": ">=0.10 <=0.12" },
    "keywords": [
        "browser",
        "cms",
        "lightweight",
        "lite",
        "mongo",
        "mongodb",
        "utility2",
        "swagger",
        "swagger-ui",
        "web"
    ],
    "license": "MIT",
    "name": "phantomjs-lite",
    "os": ["darwin", "linux"],
    "repository" : {
        "type" : "git",
        "url" : "https://github.com/kaizhu256/node-phantomjs-lite.git"
    },
    "scripts": {
        "build-ci": "node_modules/.bin/utility2 shRun shBuildCi",
        "postinstall": "./npm-postinstall.sh",
        "test": "node_modules/.bin/utility2 shRun shReadmePackageJsonExport && \
printf '\ntesting phantomjs\n' && ./phantomjs test.js && \
printf '\ntesting slimerjs\n' && ./slimerjs test.js"
    },
    "version": "2015.1.4-103"
}
```



# todo
- add screen-capture example
- none



# changelog of last 50 commits
[![screen-capture](https://kaizhu256.github.io/node-utility2/build/screen-capture.gitLog.png)](https://github.com/kaizhu256/node-utility2/commits)



# internal build-script
```
# build.sh
# this shell script will run the ci-build for this package
shBuildCi() {
    # init env
    export npm_config_mode_slimerjs=1 || return $?
    . node_modules/.bin/utility2 && shInit || return $?

    # run npm-test on published package
    shRun shNpmTestPublished || return $?

    # run npm-test
    MODE_BUILD=npmTest shRunScreenCapture npm test || return $?

    # if number of commits > 1024, then squash older commits
    shRun shGitBackupAndSquashAndPush 1024 > /dev/null || return $?
}
shBuildCi

# save exit-code
EXIT_CODE=$?

shBuildCleanup() {
    # this function will cleanup build-artifacts in local build dir
    # create package-listing
    MODE_BUILD=gitLsTree shRunScreenCapture shGitLsTree || return $?
    # create recent changelog of last 50 commits
    MODE_BUILD=gitLog shRunScreenCapture git log -50 --pretty="%ai\u000a%B" || \
        return $?
}
shBuildCleanup || exit $?

shBuildGithubUploadCleanup() {
    # this function will cleanup build-artifacts in local gh-pages repo
    return
}

# upload build-artifacts to github,
# and if number of commits > 16, then squash older commits
COMMIT_LIMIT=16 shRun shBuildGithubUpload || exit $?

# exit with $EXIT_CODE
exit $EXIT_CODE
```
