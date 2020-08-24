package main

import (
	"bytes"
	"fmt"
	"math/rand"
	"time"
)

// Field is a 2D boolean field of cells
type Field struct {
	s    [][]bool
	w, h int
}

// NewField return a field with width and height
func NewField(w, h int) Field {
	s := make([][]bool, h)
	for i := range s {
		s[i] = make([]bool, w)
	}
	return Field{s: s, w: w, h: h}
}

// Set sets boolean value to related cell
func (f Field) Set(x, y int, b bool) {
	f.s[y][x] = b
}

// Next returns next state of a cell
func (f Field) Next(x, y int) bool {
	alive := 0
	// count neighbors which are alive
	for i := -1; i <= 1; i++ { // -1, 0, 1
		for j := -1; j <= 1; j++ { // -1, 0, 1
			if f.State(x+i, y+j) && !(j == 0 || i == 0) {
				alive++
			}
		}
	}
	// exactly 3: give a brith -> 1
	// exactly 2: maintain state
	// otherwise: 0
	return alive == 3 || alive == 2 || f.State(x, y)
}

// State show related cell is alive or not
func (f Field) State(x, y int) bool {
	// if the x and y is outside of the boundary, use MOD to map the point inside boundary
	x += f.w
	x %= f.w
	y += f.h
	y %= f.h
	return f.s[y][x]
}

// Life store the state of each round
type Life struct {
	w, h int
	a, b Field
}

// NewLife retruns a new game state with randon initial state
func NewLife(w, h int) *Life {
	a := NewField(w, h)
	// choose random boundary as 0.619 as life.awk
	boundary := 0.619
	for i := 0; i < a.w; i++ {
		for j := 0; j < a.h; j++ {
			a.Set(i, j, rand.Float64() < boundary)
		}
	}
	return &Life{
		a: a,
		b: NewField(w, h),
		w: w, h: h,
	}
}

// Step moves forward one step and updating all cells
func (l *Life) Step() {
	for y := 0; y < l.h; y++ {
		for x := 0; x < l.w; x++ {
			l.b.Set(x, y, l.a.Next(x, y))
		}
	}
	l.a, l.b = l.b, l.a
}

// String returns the game as a string
func (l *Life) String() string {
	var buf bytes.Buffer
	for y := 0; y < l.h; y++ {
		for x := 0; x < l.w; x++ {
			b := byte(' ')
			if l.a.State(x, y) {
				b = 'o'
			}
			buf.WriteByte(b)
		}
		buf.WriteByte('\n')
	}
	return buf.String()
}

// replicate life.awk output format
func main() {
	l := NewLife(50, 20)
	for i := 0; i < 200; i++ {
		l.Step()
		fmt.Print("\033[1;1H") // positions the cursor at row 1, column 1
		fmt.Print("\033[2J")   // clears the entire screen
		fmt.Println(l)
		fmt.Print("Generation: ", 200-i)
		fmt.Print("\n")
		time.Sleep(time.Second / 20)
	}
}
