#include <fstream>
#include <string>

int main() {
    std::ifstream input("input.txt");
    std::ofstream output("output.txt");
    int n;
    input >> n;

    for (int i = 0; i < n; i++) {
        output << std::string(n - i - 1, ' ') << std::string(2 * i + 1, '*') << "\n";
    }
    for (int i = n - 2; i >= 0; i--) {
        output << std::string(n - i - 1, ' ') << std::string(2 * i + 1, '*') << "\n";
    }

    input.close();
    output.close();
    return 0;
}
