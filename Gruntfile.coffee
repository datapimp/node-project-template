module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean:
      release:[
       "release/*"
      ]
      build:[
        "build/*"
      ]

    copy:
      html:
        src: "build/index.html"
        dest: "release/index.html"

    concat:
      css:
        src: ['build/stylesheets/**/*.css']
        dest: 'release/stylesheets/application.css'

      templates:
        src: ['build/templates/**/*.js']
        dest: 'release/javascripts/application.js'

      js:
        src: ['build/javascripts/**/*.js']
        dest: 'release/javascripts/application.js'

    cssmin:
      minify:
        src: 'release/stylesheets/application.css'
        dest: 'release/stylesheets/application.min.css'

    uglify:
      compile:
        expand: true
        cwd: 'release/javascripts/'
        src: ['*.js', '!*.min.js']
        dest: 'release/javascripts'
        ext: '.min.js'

    jade:
      templates:
        options:
          client: true
          processName: (tmpl)->
            tmpl.replace('src/templates/','').replace('.jst.jade','')

        expand: true
        flatten: false
        src: '**/*.jst.jade'
        dest: 'build/templates'
        cwd: 'src/templates'
        ext: '.js'


      views:
        expand: true
        flatten: false
        src: '**/*.jade'
        dest: 'build/'
        cwd: 'src/views'
        ext: '.html'

    watch:
      coffee:
        files: 'src/coffeescripts/**/*.coffee'
        tasks: ['coffee']
      less:
        files: 'src/stylesheets/**/*.less'
        tasks: ['less']
      jade:
        files: 'src/templates/**/*.jade'
        tasks: ['jade']

    less:
      compile:
        expand: true
        flatten: false
        cwd: 'src/stylesheets'
        src: '**/*.less'
        dest: 'build/stylesheets/'
        ext: '.css'

    coffee:
      compile:
        expand: true
        flatten: false
        src: '**/*.coffee',
        dest: 'build/javascripts/'
        cwd: 'src/coffeescripts'
        ext: '.js'

    githubPages:
      target:
        src: "deploy"
        options:
          commitMessage: "Deploying site"


  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-github-pages"

  grunt.registerTask 'default', ['watch']

  grunt.registerTask 'deploy', ['githubpages']

  grunt.registerTask 'build',
    [
      'clean'
      'coffee'
      'less'
      'jade'
    ]

  grunt.registerTask 'release',
    [
      'build'
      'concat'
      'copy'
      'uglify'
      'cssmin'
    ]
