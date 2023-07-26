function square(n) {
    return new Promise((resolve, reject) => {
        if (typeof n !== "number") {
            reject("Invalid input");
        } else {
            setTimeout(() => {
                resolve(n * n);
            }, 1000)
        }
    });
}

function cube(n) {
    return new Promise((resolve, reject) => {
        if (typeof n !== "number") {
            reject("Invalid input");
        } else {
            setTimeout(() => {
                resolve(n * n * n);
            }, 1000)
        }
    });
}

function fourthPower(n) {
    return new Promise((resolve, reject) => {
        if (typeof n !== "number") {
            reject("Invalid input");
        } else {
            setTimeout(() => {
                resolve(Math.pow(n, 4));
            }, 3000)
        }
    });
}

Promise.race([square(2), cube(3), fourthPower(4)]).then(result => {
    console.log(result); 
}).catch(error => {
    console.log(error); 
});

Promise.any([square(2), cube(3), fourthPower(4)]).then(result => {
    console.log(result); 
}).catch(error => {
    console.log(error); 
})