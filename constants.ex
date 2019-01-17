defmodule Constants do
  @str "string"
  IO.inspect(@str)
   #in elixir we put _ after every 3 digits for better readability
   # not mandotory as such but everyone follows it.
  @number 500_000_000

  #we can directly call erlang function it won't cost any extra time a   s
  # at compile time it gets convert to beam file o   nly
  @div_num :erlang.trunc(1.79e308)

  IO.inspect(@div_num)
# elixir doesn't have match library as of now because erlang's library can be used.
  IO.inspect(:math.sin(@number))

end