const nodemailer=require('nodemailer');
const smtpTransport=require('nodemailer-smtp-transport');//send
function send(sender,receiver,message)
{
    let transporter=nodemailer.createTransport(smtpTransport({
        //конфиг smtp
        host:'smtp.gmail.com',
        port: 587,
        secure: false,
        auth:{
            user:'marinashast22@gmail.com',
            pass:'gjqmjduubsjcqeka'
        }
    }));
    var mailOptions={//параметры почты
        from: 'marinashast22@gmail.com',
        to: receiver,
        subject:'Lab5',
        text:message,
        html:`<i>${message}</i>`
    };
//отправка эмеил 
    transporter.sendMail(mailOptions,function(error,info){
        error ? console.log(error):console.log(`Email.sent:Sender-marinashast22@gmail.com Receiver-${receiver} Message-${message}`);
    })
};
module.exports=send

