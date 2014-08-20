gulp   = require 'gulp'
coffee = require 'gulp-coffee'
connect = require 'gulp-connect'
mainBowerFiles = require 'main-bower-files'

$ = require('gulp-load-plugins')({
        pattern: ['gulp-*', 'gulp.*']
        replaceString: /\bgulp[\-.]/
    })

# config
$app = './app'
$src = './src'

config =
    path:
        jade: $src + '/jade/*.jade'
        coffee: $src + '/coffee/*.coffee'
        requirejs: $app + '/assets/javascripts/'
    outpath:
        jade: $app
        coffee: $app + '/assets/javascripts/builds/'
        libs: $app + '/assets/javascripts/builds/libs/'
        javascript: $app + '/assets/javascripts/'

# connect
gulp.task 'connect', ->
    connect.server {
        root: $app
        livereload: true
    }

# tasks

gulp.task 'bower', ->
    gulp.src(mainBowerFiles())
    .pipe(gulp.dest config.outpath.libs)

gulp.task 'coffee', ->
    gulp.src(config.path.coffee)
    .pipe $.coffee()
    .pipe gulp.dest(config.outpath.javascript)
    .pipe connect.reload()

gulp.task 'scripts', ->
    gulp.src(config.outpath.coffee+'/main.js')
        .pipe $.browserify()
        .pipe gulp.dest(config.outpath.javascript)
        .pipe connect.reload()


gulp.task 'jade', ->
    gulp.src(config.path.jade)
    .pipe $.jade()
    .pipe gulp.dest(config.outpath.jade)
    .pipe connect.reload()


    
# watch
gulp.task 'watch', ->
    gulp.watch config.path.jade, ['jade']
    gulp.watch config.path.coffee, ['coffee']
    

gulp.task 'default', ['bower','coffee', 'scripts', 'jade', 'watch', 'connect']