defmodule DeliverElixirTest do
  use ExUnit.Case
  doctest DeliverElixir

  test "greets the world" do
    assert DeliverElixir.hello() == :world
  end
end
