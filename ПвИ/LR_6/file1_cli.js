const net=require("net");

let HOST='127.0.0.1';
let PORT=40000;

var client= new net.Socket();
client.connect(PORT,HOST,()=>{
    console.log("Client connected: "+client.remoteAddress+":"+client.remotePort);
    client.write('Node');
});

client.on('data',(data)=>{
        console.log("Client GET:"+data.toString());
        client.destroy();
    });

    client.on('close',( )=>{console.log('Client close ');});
    client.on('error',(e)=>{console.log('Client error '+e);});
