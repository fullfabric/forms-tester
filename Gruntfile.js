module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

      watch: {
        js: {
          files: [ '*.coffee' ],
          tasks: [ 'coffee' ]
        },
        html: {
          files: [ '*.haml' ],
          tasks: [ 'haml' ]
        }
      },
      coffee: {
        dist: {
          files: {
            'dist/form.js' : 'form.coffee'
          }
        }
      },
      haml: {
        dist: {
          files: {
            'dist/form.html' : 'form.haml'
          }
        }
      },
      open: {
        dev: {
          path: 'dist/form.html',
          app: 'firefox'

        }
      }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-haml2html');
  grunt.loadNpmTasks('grunt-open');

  grunt.registerTask( 'default', [ 'coffee', 'haml', 'open' ] );

};