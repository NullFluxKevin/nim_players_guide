import strformat

var
  boolean_var: bool = true
  character: char = 'A'
  string_var: string = "hello"

  integer_var: int = 123
  integer_var_8_bit: int8 = 111
  integer_var_16_bit: int16 = 111
  integer_var_32_bit: int32 = 435345345
  integer_var_64_bit: int64= 435345345123435345

  unsigned_integer_var:  uint = 111
  unsigned_integer_var_8_bit:  uint8 = 111
  unsigned_integer_var_16_bit: uint16 = 111
  unsigned_integer_var_32_bit: uint32 = 435345345
  unsigned_integer_var_64_bit: uint64= 1231314

  decimal_var: float = 1.2
  decimal_var_32_bit: float32 = 1.2
  decimal_var_64_bit: float64 = 1.2

echo fmt"bool: {boolean_var}, size in bytes: {sizeof(bool)}"
echo fmt"char: {character},size in bytes: {sizeof(char)}"
# echo fmt"string: {string_var}, size in bytes: {sizeof(string)}"
echo fmt"string: {string_var}, ptr size in bytes: {sizeof(string)}, content bytes: {string_var.len}"

echo fmt"default int: {integer_var}, size in bytes: {sizeof(int)}"
echo fmt"8-bit int: {integer_var_8_bit}, size in bytes: {sizeof(int8)}"
echo fmt"16-bit int: {integer_var_16_bit}, size in bytes: {sizeof(int16)}"
echo fmt"32-bit int: {integer_var_32_bit}, size in bytes: {sizeof(int32)}"
echo fmt"64-bit int: {integer_var_64_bit}, size in bytes: {sizeof(int64)}"

echo fmt"default unsigned int: {unsigned_integer_var}, size in bytes: {sizeof(uint)}"
echo fmt"8-bit unsigned int: {unsigned_integer_var_8_bit}, size in bytes: {sizeof(uint8)}"
echo fmt"16-bit unsigned int: {unsigned_integer_var_16_bit}, size in bytes: {sizeof(uint16)}"
echo fmt"32-bit unsigned int: {unsigned_integer_var_32_bit}, size in bytes: {sizeof(uint32)}"
echo fmt"64-bit unsigned int: {unsigned_integer_var_64_bit}, size in bytes: {sizeof(uint64)}"

echo fmt"default float: {decimal_var}, size in bytes: {sizeof(float)}"
echo fmt"32-bit float: {decimal_var_32_bit}, size in bytes: {sizeof(float32)}"
echo fmt"64-bit float: {decimal_var_64_bit}, size in bytes: {sizeof(float64)}"
