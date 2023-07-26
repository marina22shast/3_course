const net=require("net");

let HOST='0.0.0.0';
let PORT=40000;

let HOST2='0.0.0.0';
let PORT2=50000;

let sum=0;

let server=net.createServer();
let server2=net.createServer();
server.on('connection',(sock)=>{
    console.log("Server connected: "+sock.remoteAddress+":"+sock.remotePort);

    sock.on('data',(data)=>{
        console.log("Server GET:",data,sum)
        sum+=data.readInt32LE();
    });

    let buf=Buffer.alloc(4);//ДЛИННА БУФЕРА
    setInterval(()=>{buf.writeInt32LE(sum,0);
    sock.write(buf)},5000);

    sock.on('close',( )=>{console.log('Server closed '+sock.remoteAddress+":"+sock.remotePort);});
    sock.on('error',( )=>{console.log('Server error '+sock.remoteAddress+":"+sock.remotePort);});

});

server2.on('connection',(sock)=>{
    console.log("Server2 connected: "+sock.remoteAddress+":"+sock.remotePort);

    //диагностика
    sock.on('data',(data)=>{
        console.log("Server2 GET:",data,sum)
        sum+=data.readInt32LE();
    });

    let buf=Buffer.alloc(4);
    setInterval(()=>{buf.writeInt32LE(sum,0);
    sock.write(buf)},5000);

    sock.on('close',( )=>{console.log('Server2 closed '+sock.remoteAddress+":"+sock.remotePort);});
    sock.on('error',( )=>{console.log('Server2 error '+sock.remoteAddress+":"+sock.remotePort);});

});

server.on('listening',( )=>{console.log('TCP-server: '+server.address().address+":"+server.address().port);});
server.on('error',(e)=>{console.log('TCP-server error: '+e);});

server2.on('listening',( )=>{console.log('TCP-server: '+server2.address().address+":"+server2.address().port);});
server2.on('error',(e)=>{console.log('TCP-server error: '+e);});

server2.listen(PORT2,HOST2);
server.listen(PORT,HOST);
