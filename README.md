headless-browser-lite
=====================
minimal npm installer for phantomjs and slimerjs with no external dependencies



## build status [![travis.ci-org build status](https://api.travis-ci.org/kaizhu256/node-headless-browser-lite.svg)](https://travis-ci.org/kaizhu256/node-headless-browser-lite)



## quickstart
```
# install phantomjs and slimerjs into ./node_modules/headless-browser-lite
npm install headless-browser-lite
# run phantomjs cli
./node_modules/headless-browser-lite/phantomjs
```



## library usage example
```
// spawn a phantomjs process to run the script 'test.js'
var headless = require('headless-browser-lite');
require('child_process').spawn(
  headless.__dirname + '/phantomjs',
  [ headless.__dirname + '/test.js' ],
  { stdio: 'inherit' }
);
```



## description of files
- .gitignore
  - .gitignore file
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
- split main.js into index.js and test.js

#### 2014.9.22
- add README.md
- initial package creation
