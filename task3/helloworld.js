function isPrime(num) {
    if (num < 2) {
        return false;
    }
    for (let i = 2; i <= Math.sqrt(num); i++) {
        if (num % i === 0) {
            return false;
        }
    }
    return true;
}

const readline = require('readline-sync');

let n = parseInt(readline.question("Enter a number: "));

console.log(`Prime numbers up to ${n}:`);
for (let i = 2; i <= n; i++) {
    if (isPrime(i)) {
        console.log(i);
    }
}
