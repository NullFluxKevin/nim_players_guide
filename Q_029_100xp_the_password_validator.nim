import strutils

# This challenge is tedious, I just want to get through it ASAP
proc isValid(password: string): bool =

  let
    cleaned = password.strip
    hasT = 'T' in cleaned
    hasAmpersand = '&' in cleaned

  if len(cleaned) < 6 or len(cleaned) > 13:
    return false

  if hasT or hasAmpersand:
    return false
  
  var
    hasUpper = false
    hasLower = false
    hasNumber = false

  for c in cleaned:
    if not hasUpper:
      hasUpper = c.isUpperAscii
    if not hasLower:
      hasLower = c.isLowerAscii
    if not hasNumber:
      hasNumber = c.isDigit

  return hasUpper and hasLower and hasNumber


when isMainModule:
  block tooShort:
    doAssert not isValid("")
    doAssert not isValid("12345")

  block tooLong:
    doAssert not isValid("tooooooooooooo loooooooooooooooong")

  block noUpper:
    doAssert not isValid("passw0rd")

  block noLower:
    doAssert not isValid("PASSW0RD")

  block noNumber:
    doAssert not isValid("Password")

  block hasT:
    doAssert not isValid("Passw0rdT")

  block hasAmpersand:
    doAssert not isValid("Passw0rd&")

  block valid:
    doAssert isValid("Passw0rd")

  echo "All tests passed"
