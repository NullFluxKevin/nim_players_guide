import sequtils
import strutils

proc askForInput*(prompt: string): string =

  while true:
    stdout.write(prompt, ": ")
    try:
      result = stdin.readLine()
    except EOFError:
      stderr.writeLine("Oops! EOF when waiting for input!")
      quit()

    if result.strip.len  == 0:
      stdout.writeline("Your input was empty! Try again!")
      continue

    return result

proc askForFloat*(prompt: string): float =

  while true:
    let input = askForInput(prompt)

    try:
      result = input.parseFloat()
    except ValueError:
      stderr.writeLine("Your input is not a number!")
      continue

    return result

proc askForFloatInRange*(prompt: string, min: float, max: float): float =
  let new_prompt = prompt & " (between " & $min & " and " & $max & " inclusive)"
  while true:
    result = askForFloat(new_prompt)

    if result >= min and result <= max:
      break
    else:
      echo "Input out of range, try again."

proc askForInt*(prompt: string): int =

  while true:
    let input = askForInput(prompt)

    try:
      result = input.parseInt()
    except ValueError:
      stderr.writeLine("Your input is not a number!")
      continue

    return result

proc askForIntInRange*(prompt: string, min: int, max: int): int =
  let new_prompt = prompt & " (between " & $min & " and " & $max & " inclusive)"
  while true:
    result = askForInt(new_prompt)

    if result >= min and result <= max:
      break
    else:
      echo "Input out of range, try again."


proc showMenuFromEnum*(enu: typedesc[enum]) = 
  for e in enu.toSeq:
    echo ord(e), ": ", e


proc pickFromEnum*[T: enum](prompt: string): T = 
  showMenuFromEnum(T)
  let choice = askForIntInRange("Pick soup type", ord(low(T)), ord(high(T)))
  T(choice)

