# Elixir Function Examples

IO.inspect("--- Anonymous Functions ---")

# Using fn ... end syntax
add_fn_verbose = fn a, b -> a + b end
IO.inspect {:add_fn_verbose_result, add_fn_verbose.(5, 3)}

# Using capture operator &(&1...) syntax
add_fn_shorthand = &(&1 + &2)
IO.inspect {:add_fn_shorthand_result, add_fn_shorthand.(10, 2)}

multiply_by_two = &(&1 * 2)
IO.inspect {:multiply_by_two_result, multiply_by_two.(7)}


IO.inspect("\n--- Passing Anonymous Functions ---")
numbers = [1, 2, 3, 4, 5]
squared_numbers = Enum.map(numbers, &(&1 * &1))
IO.inspect {:squared_numbers, squared_numbers}

tripled_numbers = Enum.map(numbers, fn x -> x * 3 end)
IO.inspect {:tripled_numbers, tripled_numbers}


IO.inspect("\n--- Named Functions within a Module ---")
defmodule MyMath do
  # Simple named function
  def add(a, b) do
    a + b
  end

  def subtract(a, b) do
    a - b
  end
end

IO.inspect {:my_math_add_result, MyMath.add(15, 5)}
IO.inspect {:my_math_subtract_result, MyMath.subtract(10, 3)}


IO.inspect("\n--- Named Functions with Multiple Clauses (Pattern Matching) ---")
defmodule Greeter do
  def greet(:john) do
    "Hello, John!"
  end

  def greet(:jane) do
    "Hi, Jane!"
  end

  def greet(name) when is_binary(name) do
    "Greetings, #{name}."
  end

  def greet(_) do
    "Hello, stranger."
  end
end

IO.inspect {:greet_john, Greeter.greet(:john)}
IO.inspect {:greet_jane, Greeter.greet(:jane)}
IO.inspect {:greet_custom_name, Greeter.greet("Alex")}
IO.inspect {:greet_stranger, Greeter.greet(123)} # Will match the fallback clause


IO.inspect("\n--- Named Functions with Guard Clauses ---")
defmodule NumberChecker do
  def check_number(x) when is_integer(x) and x > 0 do
    "#{x} is a positive integer."
  end

  def check_number(x) when is_integer(x) and x < 0 do
    "#{x} is a negative integer."
  end

  def check_number(0) do # Also a form of pattern matching, but guards can be more complex
    "The number is zero."
  end

  def check_number(x) when is_float(x) do
    "#{x} is a float, not an integer."
  end

  def check_number(_) do
    "Not a recognized number type for this specific check."
  end
end

IO.inspect {:check_positive, NumberChecker.check_number(42)}
IO.inspect {:check_negative, NumberChecker.check_number(-7)}
IO.inspect {:check_zero, NumberChecker.check_number(0)}
IO.inspect {:check_float, NumberChecker.check_number(3.14)}
IO.inspect {:check_other, NumberChecker.check_number("text")}
