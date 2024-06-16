/// 2>/dev/null ; gorun "$0" "$@" ; exit $?
package main

import (
    "fmt"
    // "log"
)

func f1() (int,string,complex128) {
    fmt.Println("Hello world")
    return 4_2, "Don't Panic",complex(15,2)
}

func f2() (i int, s string, c complex128) {
    fmt.Println("Hello world")
    i, s, c = f1()
    return
}

func f3(any ...interface{}) {
  for idx, v := range any {
    fmt.Printf("%#v ==> %#v\n", idx, v)
  }
}

func main() {
    l,m,c := f1()
    fmt.Printf("%v => %v & %#v\n", l, m, c)
    l,m,c = f2()
    fmt.Printf("%v => %v & %#v\n", l, m, c)
    f3("hello world", 1, 2.3, 8, map[string]int{"mon":0,"tue":1},"\xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e", c)
}
