defmodule DeliverElixir.Orders.ItemTest do
  use ExUnit.Case

  alias DeliverElixir.Orders.Item

  import DeliverElixir.Factory

  describe "build/4" do
    test "if all parameters are valid, returns an item" do
      response = Item.build("Pizza de Mussarela", :pizza, "10.55", 3)

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "if there is an error in category field, returns an error" do
      response = Item.build("Pizza de Mussarela", :NO_CATEGORY, 10.55, 3)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "if there is an error in price (invalid price), returns an error" do
      response = Item.build("Pizza de Mussarela", :pizza, "ZERO", 3)

      expected_response = {:error, "Invalid unit price"}

      assert response == expected_response
    end

    test "if there is an error in quantity, returns an error" do
      response = Item.build("Pizza de Mussarela", :pizza, 10.55, 0)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
