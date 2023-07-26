var http = require('http');
var fs = require('fs');

http.createServer((request, response) => {
    const httpFileName = './xmlhttprequest.html';

    if (request.url === '/api/name')
    {
        response.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
        response.end('Шастовская Марина Сергеевна')
    }
    else if (request.url === '/xmlhttprequest')
    {
        fs.readFile(httpFileName, (error, data) => {//(,кодировка,функция обратного вызова)
            response.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
            error != null ? 
            console.log("error:" + error) : response.end(data);
        });
    }
    else 
        response.end('<html><body><h1>Error! Visit localhost:5000/xmlhttprequest</h1></body></html>')
}).listen(5000, () => console.log('Server running at localhost:5000/xmlhttprequest'));