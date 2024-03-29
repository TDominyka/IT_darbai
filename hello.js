#!/usr/bin/nodejs

var http=require('http');
var url=require('url');
var fs=require('fs');

http.createServer(function (req, res){
	var address=url.parse(req.url, true);
	var fileName="." + address.pathname + ".html";
	fs.readFile(fileName, function(err, data){
		if (err){
			res.writeHead(404, {'Content-Type': 'text/html'});
			return res.end("404 Not Found"); 
		}
		res.writeHead(200, {'Content-Type': 'text/html'});
		res.write(data);		
		res.end();
	});
}).listen(8008);
