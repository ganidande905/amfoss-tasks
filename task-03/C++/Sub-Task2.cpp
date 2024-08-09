#include <fstream>
#include <string>

int main() {
    std::ifstream input("input.txt");
    std::ofstream output("output.txt");
    std::string line;

    while (getline(input, line)) {
        output << line << "\n";
    }

    input.close();
    output.close();
    return 0;
}
