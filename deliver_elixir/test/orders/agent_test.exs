defmodule DeliverElixir.Orders.AgentTest do
  use ExUnit.Case
  alias DeliverElixir.Orders.Agent, as: OrderAgent

  import DeliverElixir.Factory

  describe "save/1" do
    test "the ability of save an order" do
      order = build(:order)

      OrderAgent.start_link(%{})

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "check out if an order is saved, returns the order wanted" do
      order = build(:order)

      {:ok, uuid} = OrderAgent.save(order)

      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert response == expected_response
    end

    test "check out if an order is not saved, returns an error" do
      response = OrderAgent.get("1010101010")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
