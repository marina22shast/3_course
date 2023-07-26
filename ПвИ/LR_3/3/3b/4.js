function genId() {
    return Date.now() * Math.random();
}

function createOrder(cardNumber) {
    return new Promise((resolve, reject) => {
        if (!validateCard(cardNumber)) {//номер карты покупателя проверять
            reject("Карта не действительна, не валидна, откланено");
        } else {//генирируется номер заказа,разрешать Promise
            setTimeout(() => {
                const orderNumber = genId();
                resolve(orderNumber);
            }, 5000);
        }
    });
}

function validateCard(cardNumber) {//для проверки карты
    console.log(`Подтверждающий номер карты ${cardNumber}`);//принимает номер карты,выводит его на консоль
    // рандомно ввыводит true или false.
    return Math.random() < 0.5;
}

//ПРОВЕРКА КАРТЫ УСПЕШНА
function proceedToPayment(orderNumber) {
    console.log(`ID ЗАКАЗА ${orderNumber}`);//принимаем 
    return new Promise((resolve, reject) => {//возвращать Promise, который рандомно разрешается либо
        setTimeout(() => {
            if (Math.random() < 0.5) {
                resolve("Платеж прошел успешно");
            } else {
                reject("Платеж не удался");
            }
        }, 3000);
    });
}

createOrder("1234567890")
    .then((orderNumber) => {
        console.log(`ID ЗАКАЗА ${orderNumber}`);
        return proceedToPayment(orderNumber);
    })
    .then((result) => {
        console.log(result); // платёж успешно выполнен или платёж не выполнен
    })
    .catch((error) => {
        console.error(error); //Карта не действительна
    });

async function handleResult() {//обработчик рез
    try {
        const orderNumber = await createOrder("1234567890");
        console.log(`ID ЗАКАЗА ${orderNumber}`);
        const result = await proceedToPayment(orderNumber);


        console.log(result); // платёж успешно выполнен или платёж не выполнен
    } catch (error) {
        console.error(error); //Карта не действительна
    }
}

handleResult();