gulp 		 = require('gulp')
coffee  	 = require('gulp-coffee')
gutil   	 = require('gulp-util')
sass    	 = require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
rename       = require('gulp-rename')
minifycss    = require('gulp-minify-css')

gulp.task 'express', ->
  express = require('express')
  app = express()
  app.use express.static(__dirname)
  app.listen 4000, '0.0.0.0'
  return

gulp.task 'coffee', ->
  gulp.src('src/coffee/*.coffee')
  	.pipe(coffee(bare: true).on('error', gutil.log))
  	.pipe gulp.dest('dist/scripts')
  return

gulp.task 'sass', ->
  gulp.src('src/sass/*.sass')
  	.pipe(sass(style: 'expanded')).on('error', gutil.log)  	
  	.pipe(rename(suffix: '.min'))
  	.pipe(minifycss())
  	.pipe gulp.dest('assets/style')
  return  

gulp.task 'livereload', ->
  tinylr = require('tiny-lr')()
  tinylr.listen 35729
  return  

gulp.task 'html', ->
  gulp.src('index.html').pipe gulp.dest('assets')
  return  

gulp.task 'watch', ->
  gulp.watch 'src/coffee/*.coffee', [ 'coffee' ]
  gulp.watch 'src/sass/*.sass', [ 'sass' ]
  gulp.watch 'index.html', [ 'html' ]
  return

gulp.task 'default', [
  'express'
  'livereload'
  'watch'
], ->


