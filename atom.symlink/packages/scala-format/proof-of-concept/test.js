//run with `node test.js test.scala`

var exec = require('child_process').exec, child;

//var files = process.argv.slice(2,process.argv.length)
var file = process.argv[2]

child = exec('/usr/bin/java -jar scalariform.jar ' + file,
  function (error, stdout, stderr){
    console.log('stdout: ' + stdout);
    console.log('stderr: ' + stderr);
    if(error !== null){
      console.log('exec error: ' + error);
    }
});
