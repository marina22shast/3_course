const udp=require("dgram");

let PORT=3000;

let server=udp.createSocket('udp4');
server.on('message',(msg,info)=>{
    console.log("Server connected: "+info.address+":"+info.port);
    console.log("Server GET:"+msg.toString())
    server.send("Echo:"+msg,info.port,info.address);
});

server.on('listening',( )=>{console.log('UDP-server: '+server.address().address+":"+server.address().port);});
server.on('error',(e)=>{console.log('UDP-server ERROR: '+e);server.close()});

server.bind(PORT);
