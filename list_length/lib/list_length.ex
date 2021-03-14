defmodule ListLength do

  def call(list), do: listLength(list, 0)

  defp listLength([], acc), do: acc

  defp listLength([head | tail] = _list , acc) do
    acc = acc + 1
    listLength(tail, acc)
  end
end
