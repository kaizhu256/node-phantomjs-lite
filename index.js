#!/usr/bin/env node
/*jslint
    evil: true,
    maxerr: 8,
    maxlen: 96,
    node: true,
    nomen: true,
*/
(function (self) {
    'use strict';
    var local;



    // run shared js-env code
    (function () {
        // init local
        local = {};
        local.modeJs = (function () {
            try {
                return self.phantom.version &&
                    typeof require('webpage').create === 'function' &&
                    'phantom';
            } catch (errorCaughtPhantom) {
                return module.exports &&
                    typeof process.versions.node === 'string' &&
                    typeof require('http').createServer === 'function' &&
                    'node';
            }
        }());
    }());
    switch (local.modeJs) {



    // run node js-env code
    case 'node':
        module.exports = require('./package.json');
        module.exports.__dirname = __dirname;
        module.exports.processSpawn = function (arg0, argList, options) {
            arg0 = arg0 || process.argv[2];
            if (arg0 === 'alljs') {
                module.exports.processSpawn('phantomjs', argList, options);
                module.exports.processSpawn('slimerjs', argList, options);
                return;
            }
            argList = argList || process.argv.slice(3);
            options = options || { stdio: [0, 1, 2] };
            switch (argList[0]) {
            case 'eval':
                argList = [__filename].concat(argList);
                break;
            }
            return require('child_process').spawn(__dirname + '/' + arg0, argList, options);
        };
        // run the cli
        if (module === require.main) {
            module.exports.processSpawn();
        }
        break;



    // run phantom js-env code
    case 'phantom':
        // require modules
        local.system = require('system');
        switch (local.system.args[1]) {
        case 'eval':
            eval(local.system.args[2]);
            break;
        default:
            self.phantom.exit();
            break;
        }
        break;
    }
}(this));
