var http = require('http');
const route = 'api/name';

http.createServer(function(request, response) {
    console.log(request.url);

    if (request.url === '/' + route)
    {
        response.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
        response.end('<h1>Шастовская Марина Сергеевна</h1>');
    }
    else
        response.end('<html><body><h1>Error! Visit localhost:5000/' + route + '</h1></body></html>');
}).listen(5000, () => 
console.log('Server running at localhost:5000/' + route));

