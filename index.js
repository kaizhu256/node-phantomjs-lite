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
        // run main module
        if (module === require.main) {
            require('child_process').spawn(
                __dirname + '/' + process.argv[2],
                [__filename].concat(process.argv.slice(3)),
                { stdio: [0, 1, 2] }
            );
        }
        break;



    // run phantom js-env code
    case 'phantom':
        // require modules
        local.system = require('system');
        switch (local.system.args[1]) {
        case 'eval':
            try {
                eval(local.system.args[2]);
            } catch (errorCaught) {
                console.error(errorCaught.stack);
            }
            self.phantom.exit();
            break;
        case 'evalWithoutExit':
            eval(local.system.args[2]);
            break;
        default:
            self.phantom.exit();
            break;
        }
        break;
    }
}(this));
