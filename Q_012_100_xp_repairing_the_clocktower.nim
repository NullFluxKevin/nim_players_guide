import helpers

const
  Tick = "tick"
  Tock = "tock"

let num = askForInt("Enter a number")

if num mod 2 == 0:
  echo Tick
else:
  echo Tock
