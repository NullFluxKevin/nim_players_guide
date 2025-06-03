import terminal
import sequtils
import random

import helpers

const n = 4

type
  Move = enum up, down, left, right, quit

proc showBoard(board:seq[int]) =
  for i, e in board:
    if e == 0:
      stdout.write("  ")
    elif e < 10:
      stdout.write("0", e)
    else:
      stdout.write(e)
     
    stdout.write(" ")
    if (i + 1) mod n == 0:
      echo()

when isMainModule:
  randomize()


  var board = toSeq(0 ..< n * n)
  var finished = toSeq(1 ..< n * n)
  finished.add(0)

  var moves = 0

  board.shuffle

  var emptySpaceIndex = board.find(0)

  eraseScreen()
  setCursorPos(0, 0)
  
  while board != finished:
    echo "Goal: Move the numbers to make them in the right ascending order."
    echo "HJKL to move. Anything else to quit."
    echo()

    echo "Moves: ", moves
    echo()

    showBoard(board)
    echo()

    let key = getCh()

    var move: Move
    case key:
    of 'k':
      move = up
    of 'j':
      move = down
    of 'h':
      move = left
    of 'l':
      move = right
    else:
      move = quit

    eraseScreen()
    setCursorPos(0, 0)

    case move:
    of up:
      let selected = emptySpaceIndex + n

      if selected >= len(board):
        continue

      swap(board[emptySpaceIndex], board[selected])
      emptySpaceIndex = selected
      inc moves
      
    of down:
      let selected = emptySpaceIndex - n

      if selected < 0:
        continue

      swap(board[emptySpaceIndex], board[selected])
      emptySpaceIndex = selected
      inc moves

    of left:
      if (emptySpaceIndex + 1) mod n == 0:
        continue

      let selected = emptySpaceIndex + 1
      swap(board[emptySpaceIndex], board[selected])
      emptySpaceIndex = selected
      inc moves
      
    of right:

      if emptySpaceIndex mod n == 0:
        continue

      let selected = emptySpaceIndex - 1
      swap(board[emptySpaceIndex], board[selected])
      emptySpaceIndex = selected
      inc moves

    of quit:
      quit()


  echo "Total moves: ", moves
