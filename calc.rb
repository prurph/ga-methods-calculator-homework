# Your code goes here
def choose_numbers(index)
  print "Number #{index + 1} (use radians for trig stuff): " # Store numbers as an array to expand functionality later
  gets.chomp.to_f
end

def choose_operator(operations)
  print "Which operation? (Valid choices: " + operations.join(" ") + " ) " # Join array shows options
  gets.chomp
end

def two_num_operation(choice_array, choice)
  choice_array[0].send(choice, choice_array[1]) # Take first number, send method choice with second number as arg
end

def factorial(number)
  if number <= 1
    return 1
  else
    number * factorial(number - 1)
  end
end

def magic_trig_calc(number, func) # Gets func from one_num_operaton's choice
  sin = (0..1000).inject(0) do |sum, n|
    sum + (-1)**n * number**(2 * n + 1) / factorial(2 * n + 1)
  end
  cos = (0..1000).inject(0) do |sum, n|
    sum + (-1)**n * number**(2 * n) / factorial(2 * n)
  end

  case func # Which function did user request
  when "sin"
    return sin
  when "cos"
    return cos
  when "tan"
    return (sin / cos)
  end
end


def one_num_operation(choice_array, choice)
  first = choice_array[0]
  case choice
  when "sq"
    return first**2
  when "sqrt"
    return first**0.5
  when "cube"
    return first**3
  else # In this case user selected "sin", "cos" or "tan"
    return magic_trig_calc(first, choice)
  end
end

def report_result(choice_array, choice, num_ops)
  if num_ops == 2
    puts "You asked me to do #{choice_array[0]} #{choice} #{choice_array[1]}"
    puts "My result is: #{two_num_operation(choice_array, choice)}"
  else
    puts "You asked me to do: #{choice} of #{choice_array[0]}"
    puts "My result is: #{one_num_operation(choice_array, choice)}"
  end
end

def run_calculator
  user_numbers = []
  user_operator = ""

  two_num_operations = ["+", "-", "*", "/", "**"]
  one_num_operations = ["sq", "sqrt", "cube", "sin", "cos", "tan"]
  all_operations = two_num_operations + one_num_operations

  until all_operations.include?(user_operator) # Prompt until valid operator
    user_operator = choose_operator(all_operations)
  end

  if two_num_operations.include?(user_operator)
    user_numbers = choose_numbers(0), choose_numbers(1) # Get two numbers (arith)
    report_result(user_numbers, user_operator, 2)
  else
    user_numbers << choose_numbers(0) # Only get one number (for sq, sqrt, etc.)
    report_result(user_numbers, user_operator, 1)
  end
end

def again
  print "Another calculation? "
  return gets.downcase.chr # .chr returns first character (no reason to chomp)
end

run_calculator

=begin Left this out because specification is to exit after one calc
while again != "n" do
  run_calculator
  again
end
=end

