import terminal

import helpers


type
  Board = array[3, array[3, string]]
 

var board: Board = [
  arrayWith(" ", 3),
  arrayWith(" ", 3),
  arrayWith(" ", 3),
]


when isMainModule:
  var current = "X"

  while true:
    # show board
    for arr in board:
      echo arr

    # show who's turn
    echo current, "'s turn'"

    # ask for input
    let row = askForIntInRange("Enter row", 0, 2)
    let col = askForIntInRange("Enter col", 0, 2)

    # validation: already has token
    if board[row][col] != " ":
      echo "Position already has token"
      continue

    board[row][col] = current

    # check for game over: win or draw
    # has won
    if board[row][0] == board[row][1] and board[row][1] == board[row][2] and board[row][2] != " ":
      echo current, " has won!"
      break
    if board[0][col] == board[1][col] and board[1][col] == board[2][col] and board[2][col] != " ": 
      echo current, " has won!"
      break
    if row == col or row + col == 2:
      if board[0][0] == board[1][1] and board[1][1] == board[2][2] and board[2][2] != " ":
        echo current, " has won!"
        break
      if board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[2][0] != " ":
        echo current, " has won!"
        break
    # is draw
    var isFull = true
    block checkIsDraw:
      for arr in board:
        for token in arr:
          if token == " ":
            isFull = false
            break checkIsDraw

    if isFull:
      echo "Draw"
      break

    # switch player
    current = if current == "X": "O" else: "X"
