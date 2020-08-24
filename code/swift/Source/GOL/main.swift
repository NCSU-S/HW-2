import Foundation

func main() {
  usleep(1000000)
  life(rows: 50, cols: 20, some: 0.619, gens: 200)
}



func life(rows: Int, cols: Int, some: Double, gens: Int) {  
  var array = [Int]()
  for _ in 1...(rows*cols) {
    let random = Double.random(in: 0.0...1.0)
    array.append(random < some ? 1 : 0)
  }
  live(a: array, rows: rows, gen: gens)
}

func live(a: [Int], rows: Int, gen: Int) {
  if gen < 1 {return}
  usleep(100000)
  print(NSString(format:"Generation %3d", gen))
  for c in 1...a.count {
    print(a[c-1] == 1 ? "o" : " ", terminator:"")
    if c % rows == 0 {
      print("\n")
    }
  }
  var b = [Int]()
  for c in 0..<a.count {
    var neighbours = getValue(array: a, index: c-1) + getValue(array: a, index: c+1)
    neighbours += getValue(array: a, index: c-rows-1) + getValue(array: a, index: c-rows) + getValue(array: a, index: c-rows+1)
    neighbours += getValue(array: a, index: c+rows-1) + getValue(array: a, index: c+rows) + getValue(array: a, index: c+rows+1)
    if a[c] == 0 {
      b.append(neighbours == 3 ? 1 : 0)
    } else {
      b.append(neighbours == 2 || neighbours == 3 ? 1 : 0)
    }
  }
  live(a: b, rows: rows, gen: gen-1)
}

func getValue(array: [Int], index: Int) -> Int {
  if index < 0 || index >= array.count {
    return 0
  } else {
    return array[index]
  }
}

main()
