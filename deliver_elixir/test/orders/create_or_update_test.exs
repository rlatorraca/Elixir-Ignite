defmodule DeliverElixir.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  alias DeliverElixir.Orders.CreateOrUpdate
  alias DeliverElixir.Users.Agent, as: UserAgent

  import DeliverElixir.Factory

  describe "call/1" do
    setup do
      cpf = "254136234"
      user = build(:user, cpf: cpf)

      DeliverElixir.starts_agents()
      UserAgent.save(user)

      item1 = %{
        category: :pizza,
        description: "Pizza de Muzzarella",
        quantity: 2,
        unity_price: "21.50"
      }

      item2 = %{
        category: :deserts,
        description: "Torta Holandeza",
        quantity: 6,
        unity_price: "7.80"
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "if all parameters are valids, saves an order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "if the app can't find an user entered an CPF number, returns an error", %{
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: "000000000", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:error, "User not found"} = response
    end

    test "if some item is invalid, returns an error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid items"}

      assert response == expected_response
    end

    test "if no items in an order, returns an error", %{
      user_cpf: cpf
    } do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid Parameters in Order"}

      assert response == expected_response
    end
  end
end
