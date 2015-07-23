var gulp = require('gulp');
var gutil = require('gulp-util');
var bower = require('bower');
var concat = require('gulp-concat');
var sass = require('gulp-sass');
var minifyCss = require('gulp-minify-css');
var rename = require('gulp-rename');
var sh = require('shelljs');
//
var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');
var preprocess = require('gulp-preprocess');

var paths = {
  www: './www',
  www_js: './www/js',
  www_src: './www_src/js',
  coffee_src: ['./www_src/js/**/*.coffee'],
  non_coffee_src: ['!./www_src/index.html', './www_src/**/*.!(coffee)'],
  index_html_src: './www_src/*.html',
  index_html_www: './www/',
  sass: ['./scss/**/*.scss'],
};

var preprocessor_context = {
  DEBUG: true
};

gulp.task('default', ['sass']);

// Added to support Coffeescript
gulp.task('coffee', function() {
  gulp.src(paths.coffee_src)
    .pipe(sourcemaps.init())
    .pipe(coffee().on('error', gutil.log)) // {bare: true}
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(paths.www_js))
});

// Coppy non Coffeescript files in the ./www_src/js directory to ./www/js
gulp.task('copy_src', function() {
  gulp.src(paths.non_coffee_src)
    .pipe(gulp.dest(paths.www))
});

// Preprocess html
gulp.task('preprocess_html', function() {
  // TODO: remove require
  var processor = preprocess({context:preprocessor_context});
  gulp.src(paths.index_html_src)
    .pipe(processor)
    .pipe(gulp.dest(paths.www));
});

gulp.task('sass', function(done) {
  gulp.src('./scss/ionic.app.scss')
    .pipe(sass({
      errLogToConsole: true
    }))
    .pipe(gulp.dest('./www/css/'))
    .pipe(minifyCss({
      keepSpecialComments: 0
    }))
    .pipe(rename({ extname: '.min.css' }))
    .pipe(gulp.dest('./www/css/'))
    .on('end', done);
});

gulp.task('watch', function() {
  gulp.watch(paths.sass, ['sass']);
  gulp.watch(paths.non_coffee_src, ['copy_src']);
  gulp.watch(paths.coffee_src, ['coffee']);
  gulp.watch(paths.index_html_src, ['preprocess_html']);
});

gulp.task('install', ['git-check'], function() {
  return bower.commands.install()
    .on('log', function(data) {
      gutil.log('bower', gutil.colors.cyan(data.id), data.message);
    });
});

gulp.task('git-check', function(done) {
  if (!sh.which('git')) {
    console.log(
      '  ' + gutil.colors.red('Git is not installed.'),
      '\n  Git, the version control system, is required to download Ionic.',
      '\n  Download git here:', gutil.colors.cyan('http://git-scm.com/downloads') + '.',
      '\n  Once git is installed, run \'' + gutil.colors.cyan('gulp install') + '\' again.'
    );
    process.exit(1);
  }
  done();
});
