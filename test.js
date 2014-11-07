// print debug info and exit
console.log('debug system.args - ' + JSON.stringify(require('system').args));
console.log('debug phantom.version - ' + JSON.stringify(phantom.version));
phantom.exit();
