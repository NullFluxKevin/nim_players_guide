var
  boolean_var: bool = false
  character: char = 'B'
  string_var: string = "Nim!"

  integer_var: int = 2354
  integer_var_8_bit: int8 = 56
  integer_var_16_bit: int16 = 5324
  integer_var_32_bit: int32 = 11111111
  integer_var_64_bit: int64= 12134134124141

  unsigned_integer_var:  uint = 444
  unsigned_integer_var_8_bit:  uint8 = 234
  unsigned_integer_var_16_bit: uint16 = 567
  unsigned_integer_var_32_bit: uint32 = 58584
  unsigned_integer_var_64_bit: uint64= 583858394

  decimal_var: float = 323.1
  decimal_var_32_bit: float32 = 54.12
  decimal_var_64_bit: float64 = 1.3343454

echo "bool: ", boolean_var, ", size in bytes: ", sizeof(bool)
echo "char: ", character, ", size in bytes: ", sizeof(char)
echo "string: ", string_var, ", size in bytes: ", sizeof(string)

echo "default int: ", integer_var, ", size in bytes: ", sizeof(int)
echo "8-bit int: ", integer_var_8_bit, ", size in bytes: ", sizeof(int8)
echo "16-bit int: ", integer_var_16_bit, ", size in bytes: ", sizeof(int16)
echo "32-bit int: ", integer_var_32_bit, ", size in bytes: ", sizeof(int32)
echo "64-bit int: ", integer_var_64_bit, ", size in bytes: ", sizeof(int64)

echo "default unsigned int: ", unsigned_integer_var, ", size in bytes: ", sizeof(uint)
echo "8-bit unsigned int: ", unsigned_integer_var_8_bit, ", size in bytes: ", sizeof(uint8)
echo "16-bit unsigned int: ", unsigned_integer_var_16_bit, ", size in bytes: ", sizeof(uint16)
echo "32-bit unsigned int: ", unsigned_integer_var_32_bit, ", size in bytes: ", sizeof(uint32)
echo "64-bit unsigned int: ", unsigned_integer_var_64_bit, ", size in bytes: ", sizeof(uint64)

echo "default float: ", decimal_var, ", size in bytes: ", sizeof(float)
echo "32-bit float: ", decimal_var_32_bit, ", size in bytes: ", sizeof(float32)
echo "64-bit float: ", decimal_var_64_bit, ", size in bytes: ", sizeof(float64)
