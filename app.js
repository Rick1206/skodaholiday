
/**
 * Module dependencies.
 */

var express = require('express');
var http = require('http');
var path = require('path');
var fs = require('fs');
var app = express();
var expressLayouts = require('express3-ejs-layout');
var welcome = require('./welcome');
var htmlStatic = require('./modules/writeHtml');
var conf = require('./modules/conf');


app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/src/views');
app.set('view engine', 'ejs');
app.engine('html', require('ejs').__express);

app.set('layout', 'myLayout') // defaults to 'layout'
app.use(expressLayouts);


app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);

app.use(require('less-middleware')({
    src: path.join(__dirname, 'src'),
    dest: path.join(__dirname, 'page'),
    compress: true
}));

app.use(express.static(path.join(__dirname, 'page')));
app.use('/zip',express.static(path.join(__dirname, 'zip')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}


htmlStatic.configure({app:app,paths:'page'});



//welcome page
app.use('/welcome',express.static(path.join(__dirname, 'welcome','public')));
app.get('/',welcome.index);
app.post('/',welcome.refresh);
app.post('/delete',welcome.delete);
app.post('/packed',welcome.packed);
//html config

app.locals(conf.locals);

//html

htmlStatic.setList(conf.pageList);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
