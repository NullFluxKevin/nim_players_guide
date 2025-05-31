import strformat
import helpers

type Position = object
  row, col: int

proc `$`(position: Position): string = 
  fmt"Position({position.row} {position.col})"

proc initPosition(row, col: int): Position =
  Position(row: row, col: col)

let row = askForInt("Enter target row")
let col = askForInt("Enter target col")
let target = initPosition(row, col )

proc right(position: Position): Position =
  initPosition(position.row, position.col + 1)

proc left(position: Position): Position =
  initPosition(position.row, position.col - 1)

proc down(position: Position): Position =
  initPosition(position.row + 1, position.col)

proc up(position: Position): Position =
  initPosition(position.row - 1, position.col)

echo "Deploying to ", target.up
echo "Deploying to ", target.down
echo "Deploying to ", target.left
echo "Deploying to ", target.right
