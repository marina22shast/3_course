var http = require("http");
var url = require("url");
const fs = require("fs");
let send=require("./my_noda_module");//////////////////////
const { request } = require("https");

http.createServer(function (request, response) {
    console.log(`Запрошенный адрес: ${request.url}`);
    var path=url.parse(request.url).pathname
    if ( path === '/send') {//экспортирует функцию send
        request.on('data',data =>{
            let r=JSON.parse(data);
            send(r.sender,r.receiver,r.message); })   
    }
    if ( path === '/') {
        let page = fs.readFileSync('./index.html');
        response.writeHead(200, {'Content-Type' : 'text/html; charset=utf-8'});
        response.end(page);
    }
}).listen(5000);
console.log("Server running at http://localhost:5000/ (http://localhost:5000/send)");