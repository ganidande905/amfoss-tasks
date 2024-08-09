with open('input.txt', 'r') as file:
    n = int(file.read().strip())

with open('output.txt', 'w') as file:
    for i in range(n):
        file.write(" " * (n - i - 1) + "*" * (2 * i + 1) + "\n")
    for i in range(n-2, -1, -1):
        file.write(" " * (n - i - 1) + "*" * (2 * i + 1) + "\n")
