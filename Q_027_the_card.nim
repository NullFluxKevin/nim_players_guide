import sequtils


type
  Color = enum red, green, blue, yellow
  Rank = enum
    one = 1,
    two, three, four, five, six, seven, eight, nine, ten,
    dollar = "$",
    percent = "%",
    caret = "^",
    ampersand = "&"

  Card = object
    color: Color
    rank: Rank


proc initDeck(): seq[Card] =
  for color in Color.toSeq:
    for rank in Rank.toSeq:
      result.add(Card(color: color, rank: rank))
      

let deck = initDeck()

for card in deck:
  echo card
