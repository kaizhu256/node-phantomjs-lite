phantomjs-lite [![NPM](https://img.shields.io/npm/v/phantomjs-lite.svg?style=flat-square)](https://www.npmjs.org/package/phantomjs-lite)
==============
minimal npm installer for phantomjs and slimerjs with zero npm dependencies



# build-status [![travis-ci.org build-status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)



# quickstart screen-capture example
#### to run this example, follow the instruction in the script below
```
# example.sh

# this shell script will
    # npm install phantomjs-lite
    # screen-capture http://phantomjs.org/screen-capture.html

# instruction
    # 1. copy and paste this entire shell script into a console and press enter
    # 2. view coverage in ./html-report/index.html

shExampleSh() {
    # npm install phantomjs-lite
    npm install phantomjs-lite@2015.3.29-10 || return $?

    # screen-capture http://phantomjs.org/screen-capture.html
    local ARG || return $?
    for ARG in phantomjs slimerjs
    do
        node_modules/.bin/phantomjs-lite $ARG evalWithoutExit "
            var file, page, url;
            file = '$(pwd)/screen-capture.$ARG.png';
            page = require('webpage').create();
            url = 'http://phantomjs.org/screen-capture.html';
            page.clipRect = { height: 768, left: 0, top: 0, width: 1024 };
            page.viewportSize = { height: 768, width: 1024 };
            console.log('$ARG opening ' + url);
            page.open(url, function () {
            });
            setTimeout(function () {
                console.log('$ARG creating screen-capture file://' + file);
                page.render(file);
                phantom.exit();
            }, 10000);
        " || return $?
    done
}

shExampleSh
```
#### output from shell
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.testExampleSh.png)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)
#### output from phantomjs
![screen-capture](https://kaizhu256.github.io/node-istanbul-lite/build/screen-capture.phantomjs.png)
#### output from slimerjs
![screen-capture](https://kaizhu256.github.io/node-istanbul-lite/build/screen-capture.slimerjs.png)



# npm-dependencies
- none



# package-listing
- phantomjs binary dynamically downloaded from https://bitbucket.org/ariya/phantomjs/downloads/
- slimerjs binary dynamically downloaded from http://download.slimerjs.org/releases/

[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.gitLsTree.png)](https://github.com/kaizhu256/node-phantomjs-lite)



# package.json
```
{
    "_packageJson": true,
    "author": "kai zhu <kaizhu256@gmail.com>",
    "bin": { "phantomjs-lite" : "index.js" },
    "description": "minimal npm installer for phantomjs and slimerjs with \
zero npm dependencies",
    "devDependencies": {
        "utility2": "2015.3.29-10"
    },
    "engines": { "node": ">=0.10 <=0.12" },
    "keywords": [
        "browser",
        "headless",
        "light", "lightweight", "lite",
        "minimal",
        "phantom", "phantomjs",
        "slimer", "slimerjs",
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
printf 'testing phantomjs\n' && \
[ $(./index.js phantomjs eval 'console.log(\"hello\")') = 'hello' ] && \
printf 'passed\n' && \
printf 'testing slimerjs\n' && \
[ $(./index.js slimerjs eval 'console.log(\"hello\")') = 'hello' ] && \
printf 'passed\n'"
    },
    "version": "2015.3.29-10"
}
```



# todo
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
    # copy phantomjs screen-capture to $npm_config_dir_build
    cp /tmp/app/screen-capture.*.png $npm_config_dir_build || \
        return $?

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
