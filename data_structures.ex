# Elixir Data Structure Examples

IO.inspect("--- List Examples ---")

# List creation
empty_list = []
IO.inspect {:empty_list, empty_list}

populated_list = [1, 2, 3, "hello", :world]
IO.inspect {:populated_list, populated_list}

# Common List operations
IO.inspect "\nList Operations:"
IO.inspect {:head_of_populated_list, hd(populated_list)}
IO.inspect {:tail_of_populated_list, tl(populated_list)}
IO.inspect {:length_of_populated_list, length(populated_list)}

list1 = [1, 2, 3]
list2 = [4, 5, 6]
concatenated_list = list1 ++ list2
IO.inspect {:concatenated_list, concatenated_list}


IO.inspect "\n\n--- Map Examples ---"

# Map creation
empty_map = %{}
IO.inspect {:empty_map, empty_map}

populated_map = %{:name => "John Doe", :age => 30, "city" => "New York"}
IO.inspect {:populated_map, populated_map}

# Accessing values in a Map
IO.inspect "\nMap Access:"
IO.inspect {:name_from_map, populated_map[:name]}
IO.inspect {:city_from_map, populated_map["city"]}
IO.inspect {:occupation_from_map_with_default, Map.get(populated_map, :occupation, "N/A")}
IO.inspect {:age_from_map_with_default, Map.get(populated_map, :age, "N/A")}


# Updating a Map
IO.inspect "\nMap Update:"
updated_map = Map.put(populated_map, :occupation, "Software Developer")
IO.inspect {:map_with_new_occupation, updated_map}

# Overwriting an existing key
map_with_updated_age = Map.put(updated_map, :age, 31)
IO.inspect {:map_with_updated_age, map_with_updated_age}


IO.inspect "\n\n--- Tuple Examples ---"

# Tuple creation
simple_tuple = {:ok, "Data processed successfully"}
IO.inspect {:simple_tuple, simple_tuple}

person_tuple = {"Alice", 25, "Engineer"}
IO.inspect {:person_tuple, person_tuple}

# Pattern matching with Tuples
IO.inspect "\nTuple Pattern Matching:"
case simple_tuple do
  {:ok, message} -> IO.inspect("Success: #{message}")
  {:error, reason} -> IO.inspect("Error: #{reason}")
end

case {:error, "File not found"} do
  {:ok, message} -> IO.inspect("Success: #{message}")
  {:error, reason} -> IO.inspect("Error: #{reason}")
end

{name, age, occupation} = person_tuple
IO.inspect("Person extracted - Name: #{name}, Age: #{age}, Occupation: #{occupation}")

# Attempting to pattern match with a different structure (will cause an error if not handled)
# To avoid crashing the script if this file were executed directly,
# we'll use a more robust case statement for demonstration.
another_tuple = {:data, 123}
case another_tuple do
  {tag, value} when is_atom(tag) and is_integer(value) ->
    IO.inspect("Matched generic data tuple: Tag=#{tag}, Value=#{value}")
  {name, age, occupation} when is_binary(name) and is_integer(age) and is_binary(occupation) ->
    IO.inspect("Matched person structure: Name=#{name}, Age=#{age}, Occupation=#{occupation}")
  _ ->
    IO.inspect("Did not match known tuple structures.")
end
