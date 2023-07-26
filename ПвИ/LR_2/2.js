var http = require('http');
var fs = require('fs');

http.createServer(function (request, response) {
    const fname = './тюльпаны.jpg';
    let jpg = null;
//(путь,параметры,обратный вызов)
    fs.stat(fname, (err, stat) => {//метод который используетсям для возврата в файл
        if (err)
            console.log('error: ', err)
        else {
            jpg = fs.readFileSync(fname);
            response.writeHead(200, {'Content-Type': 'image/jpeg', 'Content-Length': stat.size});
            response.end(jpg, 'binary');
        }
    })
}).listen(5000);

console.log('Server running at localhost:5000');
