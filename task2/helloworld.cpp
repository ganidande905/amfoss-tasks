#include <iostream>
#include <cmath>

bool isPrime(int num) {
    if (num < 2) {
        return false;
    }
    for (int i = 2; i <= sqrt(num); i++) {
        if (num % i == 0) {
            return false;
        }
    }
    return true;
}

int main() {
    int n;
    std::cout << "Enter a number: ";
    std::cin >> n;

    std::cout << "Prime numbers up to " << n << ":\n";
    for (int i = 2; i <= n; i++) {
        if (isPrime(i)) {
            std::cout << i << std::endl;
        }
    }

    return 0;
}
