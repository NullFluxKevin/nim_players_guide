import strformat
import helpers

type
  Product = object
    name: string
    price: int

proc initProduct(name: string, price: int): Product =
  Product(name: name, price: price)

const products: array[1..7, Product] = [
  initProduct("Rope", 10),
  initProduct("Torches", 15),
  initProduct("Climbing Equipment", 25),
  initProduct("Clean water", 1),
  initProduct("Machete", 20),
  initProduct("Canoe", 200),
  initProduct("Food Supplies", 1),
]

while true:

  for index, product in products:
    echo index, " -- ", product.name
  
  var menu_choice = askForIntInRange(
    "What number do you want to see the price of",
    low(products),
    high(products)
  )

  let product = products[menu_choice]  
  let cost = product.price.toFloat * price_modifier

  echo fmt"The cost of {product.name} is {cost} gold"
  break
