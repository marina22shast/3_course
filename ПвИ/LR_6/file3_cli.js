const udp=require("dgram");
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let PORT=3000;

let client=udp.createSocket('udp4');
rl.question('Please enter the message : ', (answer1) => {
    let message=answer1;
client.on('message',(msg,info)=>{
    console.log("Client GET:"+msg.toString());
});

client.send(message,PORT,'localhost',(e)=>{
    if(e){
    console.log(e);
    }
})

});