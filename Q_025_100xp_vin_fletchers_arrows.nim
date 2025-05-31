import strformat
import sugar
import helpers


type
  Arrowhead = enum
    ahSteel = (1, "steel"),
    ahWood = "wood",
    ahObsidian = "obsidian",

  Fletching = enum
    fPlastic = (1, "plastic"),
    fTurkeyFeathers = "turkey feathers",
    fGooseFeathers = "goose feathers",

  Price = Positive

  ArrowHeadCost = array[ArrowHead, Price]
  FletchingCost = array[Fletching, Price]
    
  ShaftLength = range[60 .. 100]

  Arrow = object
    arrowHead: Arrowhead
    fletching: Fletching
    shaftLength: ShaftLength
    

const
  shaftCostPerCM = 0.05

  arrowheadCost: ArrowHeadCost = [
    ahSteel: 10,
    ahWood: 3,
    ahObsidian: 5,
  ]

  fletchingCost: FletchingCost = [
    fPlastic: 10,
    fTurkeyFeathers: 5,
    fGooseFeathers: 3,
  ]


proc initArrow(arrowhead: Arrowhead, fletching: Fletching, shaftLength: ShaftLength): Arrow = 
  Arrow(arrowhead: arrowhead, fletching: fletching, shaftLength: shaftLength)


proc getCost(arrow: Arrow): float = 
  toFloat(
    arrowheadCost[arrow.arrowHead] + fletchingCost[arrow.fletching]
  ) + (
    shaftCostPerCM * toFloat(arrow.shaftLength)
  )

  
proc pickFromEnumArray[E: enum, T](arr: array[E, T], prompt: string, menuItemFormatter: (enumIndex: E, element: T)->string ): E =
  for enu, element in arr:
    echo menuItemFormatter(enu, element)

  let choice = askForIntInRange(prompt, ord(low(arr)), ord(high(arr)))
  E(choice)
  

proc menuItemWithCost[E: enum, T](enuIndex: E, element: T): string = 
  fmt"{ord(enuIndex)}: {enuIndex} (Cost: {element} gold)"


when isMainModule:

  let arrowhead = pickFromEnumArray(arrowheadCost, "Pick arrowhead", menuItemWithCost)
  
  let fletching = pickFromEnumArray(fletchingCost, "Pick fletching", menuItemWithCost)

  let shaftLength:ShaftLength = askForIntInRange("Enter shaft length", low(ShaftLength), high(ShaftLength))

  let arrow = initArrow(arrowhead, fletching, shaftLength)
  let cost = arrow.getCost

  echo "Arrow: ", arrow, "; Cost: ", cost
