import strutils
import strformat

import helpers

type
  ChestState = enum
    csLocked = "locked",
    csClosed = "closed",
    csOpen = "open"

  UserAction = enum
    uaUnlock = "unlock",
    uaLock = "lock",
    uaClose = "close",
    uaOpen = "open"


var state = csLocked

while true:
  let prompt = fmt"The chest is {state}. What do you want to do"
  let userInput = askForInput(prompt)

  var action: UserAction

  try:
    action = parseEnum[UserAction](userInput.toLowerAscii)

  except ValueError:
    echo "Invalid command. Only the following are valid: open, close, lock, unlock"
    continue

  case action:
  of uaClose:
    if state == csOpen:
      state = csClosed
  of uaOpen:
    if state == csClosed:
      state = csOpen
  of uaLock:
    if state == csClosed:
      state = csLocked
  of uaUnlock:
    if state == csLocked:
      state = csClosed
