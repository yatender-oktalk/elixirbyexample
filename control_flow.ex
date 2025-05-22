# Elixir Control Flow Examples

# if/else conditional statement
IO.inspect("if/else example:")
age = 20
if age >= 18 do
  IO.inspect("You are an adult.")
else
  IO.inspect("You are a minor.")
end

# cond conditional statement
IO.inspect("\ncond example:")
score = 85
cond do
  score >= 90 -> IO.inspect("Grade: A")
  score >= 80 -> IO.inspect("Grade: B")
  score >= 70 -> IO.inspect("Grade: C")
  true -> IO.inspect("Grade: D or F")
end

# case expression for pattern matching
IO.inspect("\ncase example:")
value = {:ok, "Success"}
case value do
  {:ok, message} -> IO.inspect("Operation successful: #{message}")
  {:error, reason} -> IO.inspect("Operation failed: #{reason}")
  _ -> IO.inspect("Unknown value")
end

value2 = {:error, "Something went wrong"}
case value2 do
  {:ok, message} -> IO.inspect("Operation successful: #{message}")
  {:error, reason} -> IO.inspect("Operation failed: #{reason}")
  _ -> IO.inspect("Unknown value")
end

value3 = "random"
case value3 do
  {:ok, message} -> IO.inspect("Operation successful: #{message}")
  {:error, reason} -> IO.inspect("Operation failed: #{reason}")
  _ -> IO.inspect("Unknown value: #{value3}")
end
