import terminal

for i in 1 .. 100:
  if i mod 3 == 0 and i mod 5 == 0:
    stdout.styledWriteLine(fgBlue, $i & ": Fire&Electric")
  elif i mod 3 == 0:
    stdout.styledWriteLine(fgRed, $i & ": Fire")
  elif i mod 5 == 0:
    stdout.styledWriteLine(fgYellow, $i & ": Electric")
  else:
    echo $i, ": Normal"
    

    
