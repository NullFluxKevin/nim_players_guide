import helpers

const arrLength = 5

var arr: array[arrLength, int]

for i in low(arr) .. high(arr):
  var number = askForInt("Enter an integer")
  arr[i] = number

var copied_arr: array[arrLength, int]

for i, num in arr:
  copied_arr[i] = num

echo "arr: ", arr
echo "copied arr: ", copied_arr
