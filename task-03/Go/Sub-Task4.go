package main
import (
    "io/ioutil"
    "strconv"
    "strings"
)

func main() {
    content, _ := ioutil.ReadFile("input.txt")
    n, _ := strconv.Atoi(strings.TrimSpace(string(content)))

    var output strings.Builder

    for i := 0; i < n; i++ {
        output.WriteString(strings.Repeat(" ", n-i-1) + strings.Repeat("*", 2*i+1) + "\n")
    }
    for i := n-2; i >= 0; i-- {
        output.WriteString(strings.Repeat(" ", n-i-1) + strings.Repeat("*", 2*i+1) + "\n")
    }

    ioutil.WriteFile("output.txt", []byte(output.String()), 0644)
}
