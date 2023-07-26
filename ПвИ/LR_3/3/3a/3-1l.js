const id = "127.0.0.1"; 
const port = 5000; 
 
const http = require("http"); 
const readline = require('readline');
 
let text = "<h1>norm</h1>"; 
let state = "norm"; 
let oldstate = ""; 
 
const server = http.createServer((request, response) => { //инф о запросе,управл отправкой ответа
    response.writeHead(200, {'Content-Type': 'text/html'});
    response.write(text); 
    response.end(); 
}); 
server.listen(port, id, function () { 
}); 

const rl = readline.createInterface({ 
    input: process.stdin, //поток 
    output: process.stdout 
}); 
 
const handleInput = (command) => { 
    if (command.trim() === 'exit') { 
        process.exit(0); 
        return; 
    } else if (command.trim() === 'norm' || command.trim() === 'test' ||  command.trim() === 'stop' || command.trim() === 'idle') { 
        oldstate = state; 
        state = command.trim(); 
        text = '<h1>' + state + '<h1>'; 
        console.log(`reg = ${oldstate} --> ${state}`); 
    } else { 
        console.log('Неизвестная команда: ' + command.trim()); 
    } 
    rl.setPrompt(`${state} --> `); 
    rl.prompt();
} 
rl.setPrompt(` ${state} --> `); 
rl.prompt(); 
rl.on('line', handleInput);