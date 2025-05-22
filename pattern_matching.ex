# Elixir Advanced Pattern Matching Examples

IO.inspect("--- List Pattern Matching ---")

# Matching head and tail
list1 = [1, 2, 3, 4]
[head1 | tail1] = list1
IO.inspect {{:head1, head1}, {:tail1, tail1}} # head1 = 1, tail1 = [2, 3, 4]

list2 = [:a]
[head2 | tail2] = list2
IO.inspect {{:head2, head2}, {:tail2, tail2}} # head2 = :a, tail2 = []

# This would raise a MatchError if uncommented, as an empty list has no head/tail.
# list_empty = []
# [head_empty | tail_empty] = list_empty
# IO.inspect {{:head_empty, head_empty}, {:tail_empty, tail_empty}}

# Matching lists of a specific length
list3 = ["apple", "banana", "cherry"]
[fruit1, fruit2, fruit3] = list3
IO.inspect {{:fruit1, fruit1}, {:fruit2, fruit2}, {:fruit3, fruit3}}

# This would raise a MatchError if the lengths don't match
# [one, two] = list3

# Matching with the cons operator (same as [head | tail])
# This is more about construction but shows the symmetry with matching
item = :first
rest_of_list = [:second, :third]
new_list = [item | rest_of_list]
IO.inspect {:new_list_via_cons, new_list}
[match_item | match_rest] = new_list
IO.inspect {{:match_item, match_item}, {:match_rest, match_rest}}


IO.inspect("\n--- Tuple Pattern Matching ---")

# Matching tuples of specific arity and content
status_ok = {:ok, "Data retrieved successfully"}
{:ok, message_ok} = status_ok
IO.inspect {:message_ok, message_ok}

status_error = {:error, "File not found", 404}
{:error, reason_error, code_error} = status_error
IO.inspect {{:reason_error, reason_error}, {:code_error, code_error}}

# Using _ to ignore elements
user_data = {:user, "John Doe", 30, "john.doe@example.com"}
{:user, name, age, _email} = user_data # email is ignored if _email is used
IO.inspect {{:name, name}, {:age, age}}


IO.inspect("\n--- Pattern Matching in Function Heads ---")
defmodule Processor do
  def process_tuple({:user, name, age}) do
    IO.inspect("Processing User Tuple: Name=#{name}, Age=#{age}")
    {:processed_user, String.upcase(name)}
  end

  def process_tuple({:event, type, data}) do
    IO.inspect("Processing Event Tuple: Type=#{type}, Data=#{inspect(data)}")
    {:processed_event, Map.put(data, :processed, true)}
  end

  def process_tuple({:coordinates, x, y, z}) do
    IO.inspect("Processing Coordinates: X=#{x}, Y=#{y}, Z=#{z}")
    {:sum_coordinates, x + y + z}
  end

  def process_list([:command, action, target]) do
    IO.inspect("Processing Command List: Action=#{action}, Target=#{target}")
    {:executed_command, "#{action} on #{target}"}
  end

  def process_list([head | tail]) do
    IO.inspect("Processing Generic List: Head=#{inspect(head)}, Tail=#{inspect(tail)}")
    {:list_parts, head, tail}
  end
end

IO.inspect Processor.process_tuple({:user, "Alice", 28})
IO.inspect Processor.process_tuple({:event, "login", %{user_id: 123}})
IO.inspect Processor.process_tuple({:coordinates, 10, 20, 30})
IO.inspect Processor.process_list([:command, :delete, "file.tmp"])
IO.inspect Processor.process_list([1, 2, 3, 4])


IO.inspect("\n--- Pin Operator (^) ---")
existing_value = "expected_status"
match_against_this = "expected_status"
other_value = "some_other_status"

case {match_against_this, "some_data"} do
  {^existing_value, data} ->
    IO.inspect("Matched with pin: existing_value=#{existing_value}, data=#{data}")
  {other_status, data} -> # This would match if `existing_value` was different
    IO.inspect("Matched other status: status=#{other_status}, data=#{data}")
end

# Example where pin prevents rebinding and forces a match
user_id = 101
# This would try to rebind user_id if ^ was not used, but with ^ it asserts equality.
# {user_id, name} = {102, "Jane"} # This would fail with MatchError
# IO.inspect {user_id, name}

case {:user_profile, 101, "Admin"} do
  {:user_profile, ^user_id, role} ->
    IO.inspect("User ID #{user_id} has role: #{role}")
  {:user_profile, other_id, role} ->
    IO.inspect("Different user ID #{other_id} has role: #{role}")
end

case {:user_profile, 102, "Editor"} do
  {:user_profile, ^user_id, role} -> # user_id is still 101, so this won't match
    IO.inspect("User ID #{user_id} has role: #{role}")
  {:user_profile, other_id, role} ->
    IO.inspect("Different user ID #{other_id} has role: #{role}") # This will match
end


IO.inspect("\n--- Destructuring Nested Data Structures ---")

# List of tuples
users_list = [
  {:person, "Mark", %{city: "London", country: "UK"}},
  {:person, "Sophia", %{city: "Paris", country: "France"}}
]

for {:person, name, %{city: city}} <- users_list do
  IO.inspect("User #{name} lives in #{city}.")
end

# Map containing a list of tuples
complex_data = %{
  id: "tx123",
  items: [
    %{name: "Laptop", price: 1200, details: %{brand: "XYZ", model: "Pro"}},
    %{name: "Mouse", price: 25, details: %{brand: "ABC", model: "Wireless"}}
  ],
  customer: {:customer_info, "David Lee", %{loyalty_id: "L007"}}
}

%{items: [%{details: %{brand: first_item_brand}} | _], customer: {:customer_info, customer_name, _}} = complex_data
IO.inspect("First item brand: #{first_item_brand}, Customer: #{customer_name}")

# Extracting multiple items from a list within a map
%{items: [item1, item2]} = complex_data
%{name: item1_name, price: item1_price} = item1
%{name: item2_name, price: item2_price} = item2
IO.inspect("Item 1: #{item1_name} at $#{item1_price}")
IO.inspect("Item 2: #{item2_name} at $#{item2_price}")

# Using case for more complex destructuring
case complex_data do
  %{id: transaction_id, items: [%{name: first_item, details: %{model: model_name}} | _rest_items], customer: {:customer_info, cust_name, %{loyalty_id: loyalty}}} ->
    IO.inspect("Transaction #{transaction_id}: First item is a #{model_name} #{first_item} for customer #{cust_name} (Loyalty: #{loyalty}).")
  _ ->
    IO.inspect("Complex data structure did not match the desired pattern.")
end
