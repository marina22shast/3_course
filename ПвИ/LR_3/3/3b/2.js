function secondJob() {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            reject('Error: Something went wrong');
        }, 3000);//откланяется
    });
}

// Обработка Promise
secondJob().then(result => {
    console.log(result);
}).catch(error => {
    console.error(error); 
});

async function handleSecondJob() {
    try {
        await secondJob();
    } catch (error) {
        console.error(error); 
    }
}

handleSecondJob();