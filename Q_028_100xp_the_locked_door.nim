import helpers

type
  DoorState = enum
    dsLocked = "locked",
    dsClosed = "closed",
    dsOpen = "open",

  DoorOperation = enum
    doOpen = (1, "open"),
    doClose = "close",
    doLock = "lock",
    doUnlock = "unlock"

  Door = object
    passcode: string
    state: DoorState


when isMainModule:
  let passcode = askForInput("Enter new passcode for door")
  var door = Door(state: dsLocked, passcode: passcode)

  while true:
    echo "The door is ", door.state
    let operation = pickFromEnum[DoorOperation]("What do you want to do with the door")

    case operation:
    of doOpen:
      if door.state == dsClosed:
        door.state = dsOpen
  
    of doClose:
      if door.state == dsOpen:
        door.state = dsClosed

    of doLock:
      if door.state == dsClosed:
        door.state = dsLocked

    of doUnlock:
      if door.state == dsLocked:
        let passcode = askForInput("Enter passcode to unlock")
        if passcode == door.passcode:
          door.state = dsClosed
      
