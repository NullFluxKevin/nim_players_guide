import strutils
import random

import helpers


const
  words = [
    "hello",
    "world",
  ]

  maxTries = 3


when isMainModule:
  randomize()

  let
    word = sample(words).toLowerAscii.strip

  var
    masked = "_".repeat(len(word))
    remaining = maxTries
    incorrect: seq[char] = @[]

  while masked != word and remaining > 0:
    echo "Word: ", masked
    echo "Remaining: ", remaining
    echo "Incorrect: ", incorrect.join("")
    let input = askForInput("Guess a character").toLowerAscii

    if input.len != 1:
      echo "Enter SINGLE letter"
      continue

    let character = input[0]
    if character in incorrect or character in masked:
      echo "You have picked this character. Try again."
      continue

    if character in word:

      # Nope. grug, remember: complexity bad 
      # 
      # let indices = toSeq(0 ..< len(word)).filter(
      #   (i: int)->bool => word[i] == character
      # )

      # for i in indices:
      #   masked[i] = character
      #
      
      for i, c in word:
        if c == character:
          masked[i] = character

    else:
      dec remaining 
    
    
  if masked == word:
    echo "You won!"
  else:
    echo "You Lose!"
