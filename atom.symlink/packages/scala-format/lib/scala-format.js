
/*
 * This file is the entry point of your package. It will be loaded once as a
 * singleton.
 *
 * For more information: https://atom.io/docs/latest/creating-a-package#source-code
 */
module.exports = {

  /*
   * This required method is called when your package is activated. It is passed
   * the state data from the last time the window was serialized if your module
   * implements the serialize() method. Use this to do initialization work when
   * your package is started (like setting up DOM elements or binding events).
   */
  activate: function() {
    return atom.commands.add('atom-workspace', 'scala-format:format', this.format);
  },

  /*
   * This optional method is called when the window is shutting down, allowing
   * you to return JSON to represent the state of your component. When the
   * window is later restored, the data you returned is passed to your module's
   * activate method so you can restore your view to where the user left off.
   */
  serialize: function() {
    return console.log('serialize()');
  },

  /*
   * This optional method is called when the window is shutting down. If your
   * package is watching any files or holding external resources in any other
   * way, release them here. If you're just subscribing to things on window, you
   * don't need to worry because that's getting torn down anyway.
   */
  deactivate: function() {
    return console.log('deactivate()');
  },

  /*
   * This method formats the active file using scalariform
   *
   */
  format: function() {
    console.log("format()");
    var exec = require('child_process').exec, child;
    var scalariform = atom.packages.getLoadedPackage('scala-format').path + '/bundle/scalariform.jar'

    var filepath = atom.workspace.getActiveEditor() && atom.workspace.getActiveEditor().getPath();
    console.log("file "+filepath);

    if(!filepath || !filepath.endsWith('.scala')){
      console.log('Not a path of not a .scala file. Doing nothing');
      return;
    }

    child = exec('/usr/bin/java -jar ' +scalariform +' '+ filepath,
      function (error, stdout, stderr){
        console.log('stdout: ' + stdout);
        console.log('stderr: ' + stderr);
        if(error !== null){
          console.log('exec error: ' + error);
        } else {
          console.log('scala file formatted');
        }
    });
  }
};
