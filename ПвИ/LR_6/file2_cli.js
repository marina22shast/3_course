const net=require("net");
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let HOST='127.0.0.1';
let PORT=0;
let X=0;


var client= new net.Socket();
var buf= new Buffer.alloc(4);
let timer=null;
rl.question('Please enter the port number : ', (answer1) => {
    rl.question('Please enter the number : ', (answer2) => {
    PORT=answer1;
    X=answer2;

client.connect(PORT,HOST,()=>{
    console.log("Client connected: "+client.remoteAddress+":"+client.remotePort);
    
    timer=setInterval(()=>{
        buf.writeInt32LE(X,0);
        client.write(buf);
    },1000);

    setTimeout(()=>{
        clearInterval(timer);
        client.destroy();
    },30000);
});

client.on('data',(data)=>{
        console.log("Client GET:"+data.readInt32LE());
    });

    client.on('close',( )=>{console.log('Client close ');});
    client.on('error',(e)=>{console.log('Client error '+e);});
    
});
});