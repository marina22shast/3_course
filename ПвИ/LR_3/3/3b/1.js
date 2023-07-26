function firstJob() {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve('Hello World');
        }, 2000);
    });
}

// Обработка Promise
firstJob().then(result => {
    console.log(result); 

}).catch(error => {
    console.error(error);
});

async function handleFirstJob() {
    try {
        const result = await firstJob();
        console.log(result); 
    } catch (error) {
        console.error(error);
    }
}

handleFirstJob();