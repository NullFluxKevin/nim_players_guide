
var arr = [4, 51, -7, 13, -99, 15, -8, 45, 90]

proc avg(numbers: openArray[int]) : float =
  doAssert numbers.len > 0
  var sum = 0
  for num in numbers:
    sum += num

  result = sum / len(numbers)
    
proc minimum(numbers: openArray[int]) : int =
  doAssert numbers.len > 0
  result = numbers[0]

  for num in numbers:
    if num < result:
      result = num

  
echo "arr: ", arr
echo "avg: ", avg(arr)
echo "min: ", minimum(arr)
