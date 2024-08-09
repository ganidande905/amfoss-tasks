#include <stdio.h>

int main() {
    FILE *input = fopen("input.txt", "r");
    FILE *output = fopen("output.txt", "w");
    int n;
    fscanf(input, "%d", &n);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n - i - 1; j++) fprintf(output, " ");
        for (int j = 0; j < 2 * i + 1; j++) fprintf(output, "*");
        fprintf(output, "\n");
    }

    for (int i = n - 2; i >= 0; i--) {
        for (int j = 0; j < n - i - 1; j++) fprintf(output, " ");
        for (int j = 0; j < 2 * i + 1; j++) fprintf(output, "*");
        fprintf(output, "\n");
    }

    fclose(input);
    fclose(output);
    return 0;
}
