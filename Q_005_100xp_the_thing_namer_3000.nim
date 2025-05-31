import strutils, strformat

echo "What kind of thing are we talking about?"
var name = readLine(stdin).strip()
echo "How would you describe it? Big? Azure? Tattered?"
var adjective = readLine(stdin).strip()
var suffix = "Doom"
var version = "3000"

echo fmt"The {adjective} {name} of {suffix} {version}!"
