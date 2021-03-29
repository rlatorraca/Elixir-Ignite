defmodule DeliverElixir.Orders.OrderTest do
  use ExUnit.Case

  alias DeliverElixir.Orders.Order

  import DeliverElixir.Factory

  describe "build/2" do
    test "if all parameters are valid, returns an order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "Bife a cavalo",
          category: :meat,
          quantity: 4,
          unity_price: Decimal.new("23.45")
        )
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "if there isnt any item in an order, return an error" do
      user = build(:user)
      items = []

      response = Order.build(user, items)

      expected_response = {:error, "Invalid Parameters in Order"}

      assert response == expected_response
    end
  end
end
