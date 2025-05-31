import helpers

const
  ScoreEstate = 1
  ScoreDuchy = 3
  ScoreProvince = 6

  
let estates = askForInt("Enter number of estates")
let duchies = askForInt("Enter number of duchy")
let provinces = askForInt("Enter number of province")

let totalScore = estates * ScoreEstate + duchies * ScoreDuchy + provinces * ScoreProvince

echo "Total score: ", totalScore



