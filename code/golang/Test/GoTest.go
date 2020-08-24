package math

import (
    "math"
    "testing"
)

func TestAbs(t *testing.T) {
    var a, expect float64 = -10, 10

    actual := math.Abs(a)
    if actual != expect {
        t.Fatalf("a = %f, actual = %f, expected = %f", a, actual, expect)
    }
}