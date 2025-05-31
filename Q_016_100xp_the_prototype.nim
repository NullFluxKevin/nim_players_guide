import helpers


proc guessTheNumber() = 
  let num = askForIntInRange("User 1, enter a number", 0, 100)

  var guess = -1

  while guess != num:
    guess = askForIntInRange("User 2, guess the number", 0, 100)

    if guess < num:
      echo "Too small"
    elif guess > num:
      echo "Too big"

  echo "You guessed the number"


when isMainModule:
  guessTheNumber()
