#include <stdio.h>

int main() {
    FILE *input = fopen("input.txt", "r");
    FILE *output = fopen("output.txt", "w");
    char ch;

    while ((ch = fgetc(input)) != EOF) {
        fputc(ch, output);
    }

    fclose(input);
    fclose(output);
    return 0;
}
