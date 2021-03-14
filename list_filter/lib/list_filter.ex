defmodule ListFilter do

  def call(list) do

    lista = Enum.flat_map(list, fn string ->
              case Integer.parse(string) do
                # transform to integer
                {int, _rest} -> [int]
                # skip the value
                :error -> []
              end
          end)
    Enum.count(lista, fn x -> rem(x,2) == 1 end)
   

  end

end
