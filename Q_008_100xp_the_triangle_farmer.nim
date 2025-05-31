import strformat
import helpers

proc triangleArea(base, height: float): float =
  base * height / 2

let base = askForFloat("Enter the base of the triangle")
let height = askForFloat("Enter the height of the triangle")


let area = triangleArea(base, height)
echo fmt"The area of the triangle is: {area}"

