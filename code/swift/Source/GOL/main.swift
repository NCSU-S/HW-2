/*
usage: gawk -f life.awk
Then hit and hold the return key.
For each key press, you get one new generation.

Each generation, a cell C is alive 1 or dead 0.
In the next generation each cell C is alive or dead
depending on a count of its neighbours N

  Now Neighbors           Next
  --- ---------           --------------
  1   0,1             ->  0  # Lonely
  1   4,5,6,7,8       ->  0  # Overcrowded
  1   2,3             ->  1  # Lives
  0   3               ->  1  # It takes three to give birth!
  0   0,1,2,4,5,6,7,8 ->  0  # Barren

Code citation : https://gist.github.com/timm/1f4e45d46e4788ee43f12ebe54409b2f#file-life-awk
*/

import Foundation

func main() {
  usleep(1000000)
  clearScreen()
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
  sleep()
  homeScreen()
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
    b.append(neighbours == 2 || neighbours == 3 ? 1 : 0)
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

func sleep() {usleep(100000)}
func homeScreen() {print("\033[1;1H")}
func clearScreen() {print("\033[2J")}

main()
