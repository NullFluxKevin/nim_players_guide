import sequtils
import random

# first run: nimble install fusion
import fusion/matching
{.experimental: "caseStmtMacros".}

type
  Choice = enum
    rock, paper, scissors


proc poorMansPatternMatching() = 
  echo "string case as pattern matching workaround"
  var p1Wins = 0
  var p2Wins = 0
  var draws = 0

  let choices = Choice.toSeq

  for i in 1 .. 10:
    let p1 = choices.sample
    let p2 = choices.sample

    echo "p1: ", p1, "; p2: ", p2

    if p1 == p2:
      draws.inc

    else:

      case $p1 & $p2:
      of $rock & $scissors, $scissors & $paper, $paper & $rock:
        p1Wins.inc
      else:
        p2Wins.inc

    echo "Round ", i, ": p1:p2 = ", p1Wins, ":", p2Wins, "; Draws: ", draws


proc useOutcomeLookUpTable() =
  echo "Look up table"
  type Outcome = enum
    win, lose, draw

  let outcomes: array[Choice, array[Choice, Outcome]] = [
    rock: [
      rock: draw,
      paper: lose,
      scissors: win,
    ],
    paper: [
      rock: win,
      paper: draw,
      scissors: lose,
    ],
    scissors: [
      rock: lose,
      paper: win,
      scissors: draw,
    ],
  ]

  var p1Wins = 0
  var p2Wins = 0
  var draws = 0

  let choices = Choice.toSeq

  for i in 1 .. 10:
    let p1 = choices.sample
    let p2 = choices.sample

    echo "p1: ", p1, "; p2: ", p2

    case outcomes[p1][p2]:
    of win:
      p1Wins.inc
    of lose:
      p2Wins.inc
    of draw:
      draws.inc

    echo "Round ", i, ": p1:p2 = ", p1Wins, ":", p2Wins, "; Draws: ", draws
  

proc experimentalPatternMatching() = 
  echo "Experimental pattern matching"
  var p1Wins = 0
  var p2Wins = 0
  var draws = 0

  let choices = Choice.toSeq

  for i in 1 .. 10:
    let p1 = choices.sample
    let p2 = choices.sample

    echo "p1: ", p1, "; p2: ", p2

    if p1 == p2:
      draws.inc

    else:

      case (p1, p2):
      of (rock, scissors), (scissors, paper), (paper, rock):
        p1Wins.inc
      else:
        p2Wins.inc

    echo "Round ", i, ": p1:p2 = ", p1Wins, ":", p2Wins, "; Draws: ", draws

when isMainModule:
  randomize()
  poorMansPatternMatching()
  useOutcomeLookUpTable()
  experimentalPatternMatching()


