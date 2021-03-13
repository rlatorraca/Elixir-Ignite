defmodule SumListTest do
  use ExUnit.Case # Traz todas funcionalidades da suite de testes
  #doctest SumList => Executa e testa a documentacao

  describe "call/1" do
    test "returns the lsit sum" do
      list = [ 1 , 2 , 3, 4]

      response = SumList.call(list)
      expected_response = 10

      assert response == expected_response
    end
  end
end
