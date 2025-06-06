import sequtils
import random
import strformat
import strutils


type
  ItemKind = enum arrow, bow, rope, water, food, sword

  InventoryItem = object
    weight, volume: float
    kind: ItemKind
  
  Pack = object
    maxWeight, weight: float
    maxVolume, volume: float
    maxItemCount: Natural
    items: seq[InventoryItem]

const
  items: array[ItemKind, InventoryItem] = [
    arrow: InventoryItem(kind: arrow ,weight: 0.1, volume: 0.05),
    bow: InventoryItem(kind: bow,weight: 1, volume: 4),
    rope: InventoryItem(kind: rope,weight: 1, volume: 1.5),
    water: InventoryItem(kind: water,weight: 2, volume: 3),
    food: InventoryItem(kind: food,weight: 1, volume: 0.5),
    sword: InventoryItem(kind: sword,weight: 5, volume: 3),
  ]

proc `$`(item: InventoryItem): string =
  fmt"{item.kind} (weight: {item.weight:.2f} volume: {item.volume:.2f})"

proc `$`(pack: Pack): string =
  fmt"""
  Pack:
  Items: {len(pack.items)}/{pack.maxItemCount}
  Weight: {pack.weight:.2f}/{pack.maxWeight:.2f}
  Volume: {pack.volume:.2f}/{pack.maxVolume:.2f}
  Items: {pack.items}
  """.unindent

proc add(pack: var Pack, item: InventoryItem): bool =
  if len(pack.items) >= pack.maxItemCount or
    pack.volume + item.volume > pack.maxVolume or
    pack.weight + item.weight > pack.maxWeight:
    return false

  pack.items.add(item)
  pack.volume += item.volume
  pack.weight += item.weight
  return true

when isMainModule:
  randomize()

  var pack = Pack(maxWeight: 10, maxVolume: 10, maxItemCount: 30)
  while true:
    let nextItem = items[sample(toSeq(ItemKind))]
    echo "trying to add: ", nextItem
    if not pack.add(nextItem):
      echo "Can't add more items"
      echo pack
      break

    echo pack

