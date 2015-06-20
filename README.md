phantomjs-lite
==============
minimal npm installer for phantomjs and slimerjs with zero npm-dependencies

[![NPM](https://img.shields.io/npm/v/phantomjs-lite.svg?style=flat-square)](https://www.npmjs.org/package/phantomjs-lite)



# screen-capture
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.slimerjs.png)](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.slimerjs.png)



# build-status [![travis-ci.org build-status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)

| git-branch : | [master](https://github.com/kaizhu256/node-phantomjs-lite/tree/master) | [beta](https://github.com/kaizhu256/node-phantomjs-lite/tree/beta) | [alpha](https://github.com/kaizhu256/node-phantomjs-lite/tree/alpha)|
|--:|:--|:--|:--|
| build-artifacts : | [![build-artifacts](https://kaizhu256.github.io/node-phantomjs-lite/glyphicons_144_folder_open.png)](https://github.com/kaizhu256/node-phantomjs-lite/tree/gh-pages/build..master..travis-ci.org) | [![build-artifacts](https://kaizhu256.github.io/node-phantomjs-lite/glyphicons_144_folder_open.png)](https://github.com/kaizhu256/node-phantomjs-lite/tree/gh-pages/build..beta..travis-ci.org) | [![build-artifacts](https://kaizhu256.github.io/node-phantomjs-lite/glyphicons_144_folder_open.png)](https://github.com/kaizhu256/node-phantomjs-lite/tree/gh-pages/build..alpha..travis-ci.org)|

#### master branch
- stable branch
- HEAD should be tagged, npm-published package

#### beta branch
- stable branch
- HEAD should be latest, npm-published package

#### alpha branch
- unstable branch
- HEAD is arbitrary
- commit history may be rewritten



# quickstart screen-capture example

#### to run this example, follow the instruction in the script below
- example.sh

```shell
# example.sh

# this shell script will
    # npm install phantomjs-lite
    # screen-capture http://phantomjs.org/screen-capture.html

# instruction
    # 1. copy and paste this entire shell script into a console and press enter
    # 2. view ./screen-capture.phantomjs.png
    # 3. view ./screen-capture.slimerjs.png

shExampleSh() {
    # npm install phantomjs-lite
    npm install phantomjs-lite || return $?

    # screen-capture http://phantomjs.org/screen-capture.html
    local ARG0 || return $?
    for ARG0 in phantomjs slimerjs
    do
        node_modules/phantomjs-lite/index.js $ARG0 eval "
            var file, page, url;
            file = '$(pwd)/screen-capture.$ARG0.png';
            page = require('webpage').create();
            url = 'http://phantomjs.org/screen-capture.html';
            // init webpage size and offset
            page.clipRect = { height: 768, left: 0, top: 0, width: 1024 };
            page.viewportSize = { height: 768, width: 1024 };
            // open webpage
            page.open(url, function () {
                console.log('$ARG0 opened ' + url);
                // after opening webpage,
                // wait 1000 ms and then create screen-capture and exit
                setTimeout(function () {
                    page.render(file);
                    console.log('$ARG0 created screen-capture file://' + file);
                    phantom.exit();
                }, 1000);
            });
            // init 30000 ms timeout error
            setTimeout(function () {
                console.error('$ARG0 timeout error');
                phantom.exit(1);
            }, 30000);
        " || return $?
    done
}
shExampleSh
```

#### output from shell
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.testExampleSh.png)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)

#### output from phantomjs
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.phantomjs.png)](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.phantomjs.png)

#### output from slimerjs
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.slimerjs.png)](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.slimerjs.png)



# npm-dependencies
- none



# package-listing
- phantomjs binary dynamically downloaded from https://bitbucket.org/ariya/phantomjs/downloads/
- slimerjs binary dynamically downloaded from https://download.slimerjs.org/releases/

[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.gitLsTree.png)](https://github.com/kaizhu256/node-phantomjs-lite)



# package.json
```json
{
    "author": "kai zhu <kaizhu256@gmail.com>",
    "bin": {
        "phantomjs-lite" : "index.js",
        "phantomjs" : "phantomjs",
        "slimerjs" : "slimerjs"
    },
    "description": "minimal npm installer for phantomjs and slimerjs \
with zero npm-dependencies",
    "devDependencies": {
        "utility2": "^2015.6.1-b"
    },
    "keywords": [
        "browser",
        "capture",
        "headless", "headless-browser",
        "phantom", "phantomjs",
        "scrape", "screen", "screen-capture", "screencapture", "screenshot",
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
        "preinstall": "touch phantomjs slimerjs",
        "test": "node_modules/.bin/utility2 shRun shReadmeExportPackageJson && \
for ARG0 in phantomjs slimerjs; \
do \
printf \"testing $ARG0\n\" || exit $?; \
[ \
$(./index.js $ARG0 eval 'console.log(\"hello\"); phantom.exit();') = 'hello' \
] || exit $?; \
printf \"passed\n\" || exit $?; \
done"
    },
    "version": "1.9.8-20150610b"
}
```



# todo
- none



# change since fd2af2aa
- npm publish 1.9.8-20150610b
- remove legacy node build dependency
- none



# changelog of last 50 commits
[![screen-capture](https://kaizhu256.github.io/node-phantomjs-lite/build/screen-capture.gitLog.png)](https://github.com/kaizhu256/node-phantomjs-lite/commits)



# internal build-script
- build.sh

```shell
# build.sh

# this shell script will run the build for this package
shBuild() {
    # this function will run the main build
    # init env
    export npm_config_mode_slimerjs=1 || return $?
    . node_modules/.bin/utility2 && shInit || return $?

    # run npm-test on published package
    shNpmTestPublished || return $?

    # test example shell script
    MODE_BUILD=testExampleSh \
        shRunScreenCapture shReadmeTestSh example.sh || return $?
    # copy phantomjs screen-capture to $npm_config_dir_build
    cp /tmp/app/screen-capture.*.png $npm_config_dir_build || \
        return $?

    # run npm-test
    MODE_BUILD=npmTest shRunScreenCapture npm test || return $?
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
COMMIT_LIMIT=16 shBuildGithubUpload || exit $?

# exit with $EXIT_CODE
exit $EXIT_CODE
```
