defmodule ListFilter do

  def call(list) do
    list
      |> Enum.flat_map( fn string ->
              case Integer.parse(string) do
                # transform to integer
                {int, _rest} -> [int]
                # skip the value
                :error -> []
              end
          end)
      |> Enum.count(fn x -> rem(x,2) == 1 end)


  end

end
