type
  RGB = object
    r, g, b: range[0 .. 255]

const
  Color = (
    Black: RGB(r: 0, g: 0, b: 0),
    White: RGB(r: 255, g: 255, b: 255),
    Red: RGB(r: 255, g: 0, b: 0),
    Orange: RGB(r: 255, g: 165, b: 0),
    Yellow: RGB(r: 255, g: 255, b: 0),
    Green: RGB(r: 0, g: 255, b: 0),
    Blue: RGB(r: 0, g: 0, b: 255),
    Purple: RGB(r: 128, g: 0, b: 128),
  )

when isMainModule:
  echo Color.Orange
