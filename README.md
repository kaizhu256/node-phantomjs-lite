phantomjs-lite [![NPM](https://img.shields.io/npm/v/phantomjs-lite.svg?style=flat-square)](https://www.npmjs.org/package/phantomjs-lite) [![travis.ci-org build status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)
==============
minimal npm installer for phantomjs and slimerjs binaries with no external dependencies



## quickstart
#### this shell code runs runs the quickstart demo
```
# install phantomjs and slimerjs into ./node_modules/phantomjs-lite
npm install phantomjs-lite

# start interactive phantomjs session
./node_modules/phantomjs-lite/phantomjs
```
![screenshot](http://kaizhu256.github.io/node-phantomjs-lite/screenshot.testQuickstartSh.png)



## example nodejs code
#### this example will spawn phantomjs process to run the script 'test.js'
```
// example.js
// spawn phantomjs process to run the script 'test.js'
var phantomjs = require('phantomjs-lite');
require('child_process').spawn(
  phantomjs.__dirname + '/phantomjs',
  [ phantomjs.__dirname + '/test.js' ],
  { stdio: 'inherit' }
);
```



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
- add utility2 build

#### 2015.1.x
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
