function square(n) {
    return new Promise((resolve, reject) => {
        if (typeof n !== "number") {
            reject("Неверный ввод");
        } else {
            resolve(n * n);
        }
    });
}
function cube(n) {
    return new Promise((resolve, reject) => {
        if (typeof n !== "number") {
            reject("Неверный ввод");
        } else {
            resolve(n * n * n);
        }
    });
}
function fourthPower(n) {
    return new Promise((resolve, reject) => {
        if (typeof n !== "number") {
            reject("Неверный ввод");
        } else {
            resolve(Math.pow(n, 4));
        }
    });
}
Promise.all([square(2), cube(3), fourthPower(1)])
    .then((results) => {
        console.log(results);
    })
    .catch((error) => {
        console.log(error);
    });