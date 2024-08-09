#include <iostream>

int main() {
    int n;
    std::cout << "Enter a number: ";
    std::cin >> n;

    for (int i = 0; i < n; i++) {
        std::cout << std::string(n - i - 1, ' ') << std::string(2 * i + 1, '*') << std::endl;
    }
    for (int i = n - 2; i >= 0; i--) {
        std::cout << std::string(n - i - 1, ' ') << std::string(2 * i + 1, '*') << std::endl;
    }

    return 0;
}
