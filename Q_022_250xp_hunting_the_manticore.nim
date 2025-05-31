import strformat
import terminal

import helpers


type
  HP = range[0 .. 100]
  Distance = range[0 .. 100]
  Damage = range[1 .. 10]

  CannonDamageType = enum
    Normal, Fire, Electric, FireElectric

  AttackResult = enum
    FellShort, Hit, Overshot


const
  manticoreMaxHP: HP = 10
  cityMaxHP: HP = 15
  manticoreDamage: Damage = 1

  
# Intentional use of array and semantic indices
var damage: array[CannonDamageType, Damage]
damage[CannonDamageType.Normal] = 1
damage[CannonDamageType.Fire] = 3
damage[CannonDamageType.Electric] = 3
damage[CannonDamageType.FireElectric] = 10


proc getDamageType(round: Positive): CannonDamageType =
  if round mod 3 == 0 and round mod 5 == 0:
    CannonDamageType.FireElectric
  elif round mod 3 == 0:
    CannonDamageType.Fire
  elif round mod 5 == 0:
    CannonDamageType.Electric
  else:
    CannonDamageType.Normal


proc cannonDamage(round: Positive): Damage =
  let currentDamageType = getDamageType(round)

  # Take advantage of Nim's exhaustive case while keep the code concise
  case currentDamageType:
  of Normal, Fire, Electric, FireElectric: damage[currentDamageType]


proc showGameStatus(round: Positive, cityHP, manticoreHP: HP) = 
  let round = fmt"STATUS: Round: {round}"
  let city = fmt"City: {cityHP}/{cityMaxHP}" 
  let manticore = fmt"Manticore:{manticoreHP}/{manticoreMaxHP}"
  echo fmt"{round} {city} {manticore}"


proc gameOver(manticoreHP, cityHP: HP) =
  if manticoreHP == 0:
    stdout.styledWriteLine(fgGreen, "You destroyed the manticore!")
  if cityHP == 0:
    stdout.styledWriteLine(fgRed, "The manticore destroyed the city!")


proc cmpAttackDistance(aimDistance, actualDistance: Distance): AttackResult = 
  if aimDistance > actualDistance:
    Overshot
  elif aimDistance < actualDistance:
    FellShort
  else:
    Hit


proc askForManticoreDistance(): Distance=
  askForIntInRange(
    "Player 1, set manticore distance from city", 0, 100
  )


proc askForAimDistance(): Distance =
  askForIntInRange(
    "Player 2, set cannon range", 0, 100
  )


proc startGame() =
  var round:Positive = 1
  var manticoreHP: HP = manticoreMaxHP
  var cityHP: HP = cityMaxHP

  let manticoreDistance = askForManticoreDistance()

  while manticoreHP > 0 and cityHP > 0:

    showGameStatus(round, cityHP, manticoreHP)
    
    let aimDistance = askForAimDistance()

    case cmpAttackDistance(aimDistance, manticoreDistance):
    of FellShort:
      echo "Fell short!"
      cityHP = max(cityHP - manticoreDamage, 0)
    of Overshot:
      echo "Overshot!"
      cityHP = max(cityHP - manticoreDamage, 0)
    of Hit:
      echo "Direct hit!"
      let damage = cannonDamage(round)
      manticoreHP = max(manticoreHP - damage, 0)

    inc round

  gameOver(manticoreHP, cityHP)  
   

when isMainModule:
  startGame()
