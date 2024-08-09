package main
import (
    "io/ioutil"
)
func main() {
    content, _ := ioutil.ReadFile("input.txt")
    ioutil.WriteFile("output.txt", content, 0644)
}
