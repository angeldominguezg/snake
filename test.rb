require "byebug"

class Calculator
  def sum(a, b)
    a + b
  end
  def rest(a, b)
    a - b
  end 
end 

calc = Calculator.new
test_sum = {
  [1,2] => 3,
  [5, 6] => 11, 
  [100, 1] => 101
}

test_sum.each do |input, expected_result|
  # byebug
  if ! (calc.sum(input[0], input[1]) == expected_result)
    raise "Test failed for input #{input}. Expected result #{expected_result}."
  end
  puts test_sum
end 
