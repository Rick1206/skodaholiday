
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



app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.engine('html', require('ejs').__express);

app.set('layout', 'myLayout') // defaults to 'layout'
app.use(expressLayouts);


app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);

app.use(require('less-middleware')({ src: __dirname + '/public' }));
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
    app.locals.pretty = true;
}

app.conf = JSON.parse(fs.readFileSync('package.json','utf-8'));

htmlStatic.configure({app:app,paths:'public'});

//welcome
app.use('/welcome',express.static(path.join(__dirname, 'welcome','public')));

app.get('/',welcome.index);
app.post('/',welcome.refresh);

//html
app.locals({
    logined:0
});
htmlStatic.set('index');
htmlStatic.set('idea',{_page:0,logined:'1'});
htmlStatic.set('idea1','idea',{_page:1,logined:'1'});
htmlStatic.set('idea2','idea',{_page:2,logined:'1'});
htmlStatic.set('idea3','idea',{_page:3,logined:'1'});
htmlStatic.set('idea_logout','idea',{_page:0,logined:'0'});
http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
