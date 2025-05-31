import strformat
import strutils
import helpers


type
  Product = object
    name: string
    price: int


proc initProduct(name: string, price: int): Product =
  Product(name: name, price: price)


const
  discountUsername = "kevin"
  discount = 0.5

  inventory: array[1..7, Product] = [
    initProduct("Rope", 10),
    initProduct("Torches", 15),
    initProduct("Climbing Equipment", 25),
    initProduct("Clean water", 1),
    initProduct("Machete", 20),
    initProduct("Canoe", 200),
    initProduct("Food Supplies", 1),
  ]


proc getPriceOf(product: Product, forUser: string): float = 
  let username = forUser
  let price_modifier = if username.toLower == discountUsername : discount else: 1
  result = product.price.toFloat * price_modifier

proc showInventory() =
  for index, product in inventory:
    echo index, " -- ", product.name


proc showCost(product:Product, cost: float) =
  echo fmt"The cost of {product.name} is {cost} gold"

  
proc askForProduct(): Product =
  let menu_choice = askForIntInRange(
    "What number do you want to see the price of",
    low(inventory),
    high(inventory)
  )

  result = inventory[menu_choice]  
  

proc main() =
  let username = askForInput("Enter your name")
  showInventory()
  let product = askForProduct()
  let price = getPriceOf(product, username)
  showCost(product, price)
  

when isMainModule:
  main()
