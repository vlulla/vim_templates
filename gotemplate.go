package main

import (
    "fmt"
    // "log"
)

func f1() (int,string) {
    fmt.Println("Hello world")
    return 4_2, "Don't Panic"
}

func main() {
    l,m := f1()
    fmt.Printf("%v => %v\n", l, m)
}
