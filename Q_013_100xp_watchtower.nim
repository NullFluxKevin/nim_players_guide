import helpers

let x = askForInt("Enter x")
let y = askForInt("Enter y")

if x == 0 and y == 0:
  echo "The enemy is here!"
else:

  var direction = "" 

  if y > 0:
    direction &= "north"
  elif y < 0:
    direction &= "south"

  if x > 0:
    direction &= "east"
  if x < 0:
    direction &= "west"

  echo "Enemy direction: " & direction  
