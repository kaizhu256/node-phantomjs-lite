phantomjs-lite [![NPM](https://img.shields.io/npm/v/phantomjs-lite.svg?style=flat-square)](https://www.npmjs.org/package/phantomjs-lite) [![travis.ci-org build status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)
==============
minimal npm installer for phantomjs and slimerjs binaries with no external dependencies
![screenshot](http://kaizhu256.github.io/node-phantomjs-lite/screenshot.png)



## installation and quickstart
```
# install phantomjs and slimerjs into ./node_modules/phantomjs-lite
npm install phantomjs-lite
# run phantomjs cli
./node_modules/phantomjs-lite/phantomjs
```



## library usage example
```
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
- cli.sh
  - shell build script
- index.js
  - main nodejs app
- package.json
  - npm config file
- test.js
  - nodejs test script



## changelog
#### 2014.10.31
- remove 'unzip' dependency for installing slimerjs on linux systems
- use lightweight version of slimerjs
- better cache file download
- rename headless-browser-lite to phantomjs-lite
- split main.js into index.js and test.js

#### 2014.9.22
- add README.md
- initial package creation
