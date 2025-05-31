import strformat
import sequtils
import helpers


type
  SoupType = enum
    stSoup = (1, "soup"),
    stStew = "stew",
    stGumbo = "Gumbo"

  MainIngredient = enum
    miMushrooms = (1, "mushrooms"),
    miChicken = "chicken",
    miCarrots = "carrots",
    miPotatoes = "potatoes"

  Seasoning = enum
    sSpicy = (1, "spicy"),
    sSalty = "salty",
    sSweet = "sweet"

  Soup = tuple
    soupType: SoupType
    ingredient: MainIngredient
    seasoning: Seasoning


proc showMenuFromEnum(enu: typedesc[enum]) = 
  for e in enu.toSeq:
    echo ord(e), ": ", e


proc pickFromEnum[T: enum](prompt: string): T = 
  showMenuFromEnum(T)
  let choice = askForIntInRange("Pick soup type", ord(low(T)), ord(high(T)))
  T(choice)


when isMainModule:

  let soupType = pickFromEnum[SoupType]("Pick the soup type")
  let ingredient = pickFromEnum[MainIngredient]("Pick the main ingredient")
  let seasoning = pickFromEnum[Seasoning]("Pick the seasoning")

  let soup: Soup = (soupType, ingredient, seasoning)

  echo fmt"You ordered {soup.seasoning} {soup.ingredient} {soup.soupType}. Excellent choice!"
