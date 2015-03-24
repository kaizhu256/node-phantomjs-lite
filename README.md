phantomjs-lite [![NPM](https://img.shields.io/npm/v/phantomjs-lite.svg?style=flat-square)](https://www.npmjs.org/package/phantomjs-lite) [![travis.ci-org build status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)
==============
lightweight version of phantomjs and slimerjs with zero npm dependencies



# quickstart
#### to run this example, read the instruction inside the script below
```
# example.sh

# instruction
    # 1. copy and paste this entire shell script into a console and press enter

shExampleSh() {
  # npm install phantomjs-lite
  npm install phantomjs-lite || return $?

  # end interactive phantomjs session after 10 seconds
  /bin/sh -c "sleep 10 && killall phantomjs" &

  # start interactive phantomjs session
  ./node_modules/phantomjs-lite/phantomjs

  # reset terminal settings in case it gets mangled by phantomjs
  stty sane || return $?
}

shExampleSh
```
#### output from shell
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.testExampleSh.png)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)



# npm-dependencies
- none



# package-listing
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.gitLsTree.png)](https://github.com/kaizhu256/node-phantomjs-lite)



# package.json
```
{
    "_packageJson": true,
    "description": "lightweight version of phantomjs and slimerjs with \
zero npm dependencies",
    "devDependencies": {
        "utility2": "2015.3.19-11"
    },
    "engines": { "node": ">=0.10 <=0.12" },
    "keywords": [
        "browser",
        "light", "lightweight", "lite",
        "phantomjs",
        "slimerjs",
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
        "build-ci": "node_modules/.bin/utility2 shRun shReadmeBuild",
        "postinstall": "./npm-postinstall.sh",
        "test": "node_modules/.bin/utility2 shRun shReadmePackageJsonExport && \
printf '\ntesting phantomjs\n' && ./phantomjs test.js && \
printf '\ntesting slimerjs\n' && ./slimerjs test.js"
    },
    "version": "2015.3.20-10"
}
```



# todo
- add screen-capture example
- none



# changelog of last 50 commits
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.gitLog.png)](https://github.com/kaizhu256/node-phantomjs-lite/commits)



# internal build-script
```
# build.sh
# this shell script will run the build for this package
shBuild() {
    # init env
    export npm_config_mode_slimerjs=1 || return $?
    . node_modules/.bin/utility2 && shInit || return $?

    # run npm-test on published package
    shRun shNpmTestPublished || return $?

    # test example shell script
    MODE_BUILD=testExampleSh \
        shRunScreenCapture shReadmeTestSh example.sh || return $?

    # run npm-test
    MODE_BUILD=npmTest shRunScreenCapture npm test || return $?

    # if number of commits > 1024, then squash older commits
    shRun shGitBackupAndSquashAndPush 1024 > /dev/null || return $?
}
shBuild

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
