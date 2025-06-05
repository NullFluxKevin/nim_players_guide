import sugar
import strutils
import sequtils
import unicode
import terminal


# Box Drawing
###############################################################################
template withCursorPos(x, y: int, body: untyped) =
  let (prevX, prevY) = getCursorPos()
  setCursorPos(x, y)
  body
  setCursorPos(prevX, prevY)

type
  BoxRunes = object
    horizontal, vertical, topLeft, topRight, bottomLeft, bottomRight: Rune

  BoxRunesWithTJunctions = object
    boxRunes: BoxRunes
    leftTJunction, rightTJunction, topTJunction, bottomTJunction, cross: Rune

  Box = object
    height, width: Positive 

  Grid = object
    cellHeight, cellWidth: Positive
    rows, cols: Positive

  RenderProc = proc(content: string)


proc initBoxRunes(runes: varargs[Rune]): BoxRunes = 
  doAssert len(runes) == 6

  BoxRunes(
    horizontal: runes[0],
    vertical: runes[1],
    topLeft: runes[2],
    topRight: runes[3],
    bottomLeft: runes[4],
    bottomRight: runes[5],
  )

proc initBoxRunesWithTJunctions(boxRunes: BoxRunes, junctionRunes: varargs[Rune]): BoxRunesWithTJunctions = 
  doAssert len(junctionRunes) == 5

  BoxRunesWithTJunctions(
    boxRunes: boxRunes,
    leftTJunction: junctionRunes[0],
    rightTJunction: junctionRunes[1],
    topTJunction: junctionRunes[2],
    bottomTJunction: junctionRunes[3],
    cross: junctionRunes[4],
  )

proc initGrid(cellHeight, cellWidth, rows, cols: Positive): Grid = 
  Grid(cellHeight: cellHeight, cellWidth: cellWidth, rows: rows, cols: cols)


proc assertX(x: int) =
  doAssert x >= 0 and x <= terminalWidth()


proc assertY(y: int) =
  doAssert y >= 0 and y <= terminalHeight()


proc assertPos(x, y: int) =
  assertX(x)
  assertY(y)


proc toRune(singleRune: string): Rune = 
  doAssert singleRune.runeLen == 1
  singleRune.runeAt(0)


proc toRunes(strsOfSingleRune: openArray[string]): seq[Rune] = 
  strsOfSingleRune.map((s: string)->Rune => s.toRune)


proc drawLineHorizontal(x, y: int, length: Positive, symbol: Rune) = 
  assertPos(x, y)
  assertX(x + length)

  withCursorPos(x, y):
    stdout.write symbol.repeat length


proc drawLineVertical(x, y: int, length: Positive, symbol: Rune) = 
  assertPos(x, y)
  assertY(y + length)

  for i in 0 ..< length:
    withCursorPos(x, y + i):
      stdout.write symbol


proc drawSymbol(x, y: int, symbol: Rune) = 
  assertPos(x, y)
  withCursorPos(x, y):
    stdout.write symbol


proc drawBox(x, y: int, height, width: Positive, boxRunes: BoxRunes, clearInside=true) = 
  # height and width are lengths of vertical and horizontal runes WITHOUT corner symbols. 
  #  e.g. ┌─┐ has width of 1, not 3
   
  let
    topLeftX = x
    topLeftY = y
    bottomLeftX = topLeftX
    bottomLeftY = y + height + 1
    topRightX = x + width + 1
    topRightY = topLeftY
    bottomRightX = topRightX
    bottomRightY = bottomLeftY

  if clearInside:
    for posX in topLeftX .. topRightX:
      for posY in topLeftY .. bottomLeftY:
        withCursorPos(posX, posY):
          stdout.write " "
  
  drawSymbol(topLeftX, topLeftY, boxRunes.topLeft)
  drawSymbol(topRightX, topRightY, boxRunes.topRight)
  drawSymbol(bottomLeftX, bottomLeftY, boxRunes.bottomLeft)
  drawSymbol(bottomRightX,bottomRightY, boxRunes.bottomRight)

  drawLineHorizontal(topLeftX + 1, topLeftY, width, boxRunes.horizontal)
  drawLineHorizontal(bottomLeftX + 1,bottomLeftY, width, boxRunes.horizontal)
  drawLineVertical(topLeftX, topLeftY + 1, height, boxRunes.vertical)
  drawLineVertical(topRightX, topRightY + 1, height, boxRunes.vertical)


proc drawBox(x,y: int, box:Box, boxRunes: BoxRunes, clearInside=true) = 
  drawBox(x, y, box.height, box.width, boxRunes, clearInside)


proc drawGrid(x, y: int, cellHeight, cellWidth: Positive, rows, cols: Positive, boxRunesWithTJunctions: BoxRunesWithTJunctions) = 
# Works but put on hold to prioritize the box

  let
    # Rows and cols take space too!
    gridWidth = cellWidth * cols + cols - 1
    gridHeight = cellHeight * rows + rows - 1

    topLeftX = x
    topLeftY = y
    bottomLeftY = y + gridHeight + 1
    topRightX = x + gridWidth + 1
    bottomRightX = topRightX
    bottomRightY = bottomLeftY
 
    runes = boxRunesWIthTJunctions

  assertPos(topLeftX, topLeftY)
  assertPos(bottomRightX, bottomRightY)

  drawBox(topLeftX, topLeftY, gridHeight, gridWidth, runes.boxRunes)

  for row in 1 ..< rows:
    let
      rowLeftX = topLeftX
      rowRightX = topRightX
      rowY = topLeftY + row * cellHeight + row

    drawSymbol(rowLeftX, rowY, runes.leftTJunction)
    drawSymbol(rowRightX, rowY, runes.rightTJunction)
    drawLineHorizontal(rowLeftX + 1, rowY, gridWidth, runes.boxRunes.horizontal)

  for col in 1 ..< cols:
    let
      colTopY = topLeftY
      colBottomY = bottomLeftY
      colX = topLeftX + col * cellWidth + col

    drawSymbol(colX, colTopY, runes.topTJunction)
    drawSymbol(colX, colBottomY, runes.bottomTJunction)
    drawLineVertical(colX, colTopY + 1, gridHeight, runes.boxRunes.vertical)

  
  for row in 1 ..< rows:
    for col in 1 ..< cols:
      let
        crossX = topLeftX + col * cellWidth + col
        crossY = topLeftY + row * cellHeight + row

      drawSymbol(crossX, crossY, runes.cross)


proc drawGrid(x,y: int, grid: Grid, boxRunesWithTJunctions: BoxRunesWithTJunctions) = 
  drawGrid(x, y, grid.cellHeight, grid.cellWidth, grid.rows, grid.cols, boxRunesWithTJunctions)


proc gridRowToTerminalPosY(grid: Grid, row: int, yOffset: int): int = 
  yOffset + row * grid.cellHeight + row + 1


proc gridColToTerminalPosX(grid: Grid, col: int, xOffset: int): int = 
  xOffset + col * grid.cellWidth + col + 1



proc drawInGrid(xOffset, yOffset: int, grid: Grid, row, col: int, content: string, checkContentLength = true, renderProc: RenderProc = (content: string)=> stdout.write content ) = 
  let
    x = gridColToTerminalPosX(grid, col, xOffset)
    y = gridRowToTerminalPosY(grid, row, yOffset)


  assertPos(x, y)

  if checkContentLength:
    doAssert len(content) <= grid.cellWidth

  withCursorPos(x, y):
    renderProc content


const
  boxRunes = initBoxRunes(["─", "│", "┌", "┐", "└", "┘"].toRunes)
  boxRunesWithTJunctions = initBoxRunesWithTJunctions(
    boxRunes, ["├", "┤", "┬", "┴", "┼"].toRunes
  )


# Actual Logic
###############################################################################

type
  Token = enum empty = " ", cross = "X" , circle = "O"
  Board = array[3, array[3, Token]]

 
const
  grid = initGrid(1, 3, 3, 3)

  boardDrawingLeftMargin = 2
  boardDrawingTopMargin = 2
  messageSectionStartingRow = 10
  # col won't be consistent once echoed to a new line
  # and setCursorYPos not available on UNIX
    

var board: Board = [
  arrayWith(empty, 3),
  arrayWith(empty, 3),
  arrayWith(empty, 3),
]


proc redBG(content: string) =
  stdout.styledWrite(bgRed, content, resetStyle)


proc blueBG(content: string) =
  stdout.styledWrite(bgBlue, content, resetStyle)


proc showBoard(selectedRow: int = -1, selectedCol: int = -1, renderProc: RenderProc = (content: string)=>stdout.write content) = 

  let
    marginL = boardDrawingLeftMargin
    marginT = boardDrawingTopMargin

  drawGrid(marginL, marginT, grid, boxRunesWithTJunctions)
  for i in 0 ..< len(board):
    for j in 0 ..< len(board[0]):
      let tokenRepr = ($board[i][j]).center(int(grid.cellWidth))

      if i == selectedRow and j == selectedCol:
        drawInGrid(marginL, marginT, grid, i, j, tokenRepr, renderProc=renderProc)
      else:
        drawInGrid(marginL, marginT, grid, i, j, tokenRepr)
  echo()


proc showResult(message: string) =
  eraseScreen()
  setCursorPos(0, 0)
  showBoard()
  setCursorPos(0, messageSectionStartingRow)
  echo message


when isMainModule:
  var current = cross
  var messages:seq[string] = @[]

  while true:
    var renderProc: RenderProc  
    case current:
    of cross:
      renderProc = blueBG
    of circle:
      renderProc = redBG
    else:
      discard
      
    var
      row = 1
      col = 1 

    while true:
      eraseScreen()
      setCursorPos(0, 0)
      showBoard(row, col, renderProc)
      setCursorPos(0, messageSectionStartingRow)

      # show who's turn
      echo current, "'s turn"
      echo "Press HJKL to move, ENTER to place token. Anything else to quit." 
      if len(messages) > 0:
        for msg in messages:
          echo msg
        messages.delete(0 ..< len(messages))

      # ask for input

      let key = getch()
      case key:
      of 'h':
        col = max(col - 1, 0)
      of 'l':
        col = min(col + 1, high(board[0]))
      of 'j':
        row = min(row + 1, high(board))
      of 'k':
        row = max(row - 1, 0)
                
      of '\r':
        # validation: already has token
        if board[row][col] == empty:
          break
        else:
          messages.add("Position already has token")
      else:
        quit()


    board[row][col] = current

    # check for game over: win or draw
    # has won
    if board[row][0] == board[row][1] and board[row][1] == board[row][2] and board[row][2] != empty:
      showResult($current & " has won!")
      break
    if board[0][col] == board[1][col] and board[1][col] == board[2][col] and board[2][col] != empty: 
      showResult($current & " has won!")
      break
    if row == col or row + col == 2:
      if board[0][0] == board[1][1] and board[1][1] == board[2][2] and board[2][2] != empty:
        showResult($current & " has won!")
        break
      if board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[2][0] != empty:
        showResult($current & " has won!")
        break
    # is draw
    var isFull = true
    block checkIsDraw:
      for arr in board:
        for token in arr:
          if token == empty:
            isFull = false
            break checkIsDraw

    if isFull:
      showResult("Draw game.")
      break

    # switch player
    current = if current == cross: circle else: cross

