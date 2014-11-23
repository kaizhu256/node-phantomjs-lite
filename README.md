phantomjs-lite
==============
minimal npm installer for phantomjs and slimerjs binaries with no external dependencies



## build status [![travis.ci-org build status](https://api.travis-ci.org/kaizhu256/node-phantomjs-lite.svg)](https://travis-ci.org/kaizhu256/node-phantomjs-lite)



## quickstart
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



## description of files
- .gitignore
  - git ignore file
- .travis.yml
  - travis-ci config file
- README.md
  - readme file
- cli.sh
  - shell script for installing / testing this app
- index.js
  - this app's main program / library
- package.json
  - npm config file
- test.js
  - test script



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
