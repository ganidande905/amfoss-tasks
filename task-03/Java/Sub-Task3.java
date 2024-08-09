import java.util.Scanner;

public class DiamondPattern {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a number: ");
        int n = scanner.nextInt();

        for (int i = 0; i < n; i++) {
            System.out.print(" ".repeat(n - i - 1));
            System.out.println("*".repeat(2 * i + 1));
        }
        for (int i = n - 2; i >= 0; i--) {
            System.out.print(" ".repeat(n - i - 1));
            System.out.println("*".repeat(2 * i + 1));
        }
    }
}
