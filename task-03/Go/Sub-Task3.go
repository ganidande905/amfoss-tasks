package main
import "fmt"

func main() {
    var n int
    fmt.Print("Enter a number: ")
    fmt.Scan(&n)

    for i := 0; i < n; i++ {
        fmt.Println(" " * (n - i - 1) + "*" * (2 * i + 1))
    }
    for i := n-2; i >= 0; i-- {
        fmt.Println(" " * (n - i - 1) + "*" * (2 * i + 1))
    }
}
