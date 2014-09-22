/*jslint
  indent: 2,
  node: true, nomen: true
*/
/*global phantom*/
(function () {
  'use strict';
  if (typeof __dirname === 'string') {
    module.exports.__dirname = __dirname;
  }
  if (typeof phantom === 'object') {
    console.log(require('system').args);
    console.log(JSON.stringify(phantom.version));
    phantom.exit();
  }
}());
