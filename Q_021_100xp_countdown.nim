
proc recursiveCountdown(start: int) =
  echo start
  if start <= 1:
    return
  else:
    recursiveCountdown(start - 1)

recursiveCountdown(10)
