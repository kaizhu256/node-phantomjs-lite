headless-browser-lite
=====================
minimal npm installer for phantomjs and slimerjs with no external dependencies



## quickstart
```
## install phantomjs and slimerjs into ./node_modules/headless-browser-lite
npm install headless-browser-lite
## run phantomjs cli
./node_modules/headless-browser-lite/phantomjs
```



## library usage example
```
require('child_process').spawn(
  require('headless-browser-lite').__dirname + '/phantomjs',
  [ 'foo.js' ],
  { stdio: 'inherit' }
);
```



## description of files
- .travis.yml
  - travis-ci config file
- README.md
  - readme file
- main.js
  - this app's main program / library
- main.sh
  - shell build script used by travis-ci
- package.json
  - npm config file



## changelog
#### 2014.9.22
- add README.md
- initial package creation
