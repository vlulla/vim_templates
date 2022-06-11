package main

import (
    "fmt"
    // "log"
)

func f1() (int,string,complex128) {
    fmt.Println("Hello world")
    return 4_2, "Don't Panic",complex(15,2)
}

func main() {
    l,m,c := f1()
    fmt.Printf("%v => %v & %#v\n", l, m, c)
}
