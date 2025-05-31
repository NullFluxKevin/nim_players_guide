import helpers
const sistersCount = 4

let eggsCount = askForInt("How many eggs you gathered today")

let eggsPerSister = eggsCount div sistersCount

let eggsForDuckbear = eggsCount mod sistersCount

echo "Eggs per sister: ", eggsPerSister
echo "Eggs for duckbear: ", eggsForDuckbear

