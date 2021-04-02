defmodule DeliverElixir.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias DeliverElixir.Users.Agent, as: UserAgent
  alias DeliverElixir.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "if all parameters are valids, saves an user" do
      params = %{
        name: "RLSP",
        address: "Rua das mexiricas, 222",
        email: "rlsp@gmail.com",
        cpf: "23123123",
        age: 22
      }

      response = CreateOrUpdate.call(params)
      expected_response = {:ok, "User added sucessfully"}

      assert response == expected_response
    end

    test "if all parameters exists, returns an error" do
      params = %{
        name: "RLSP",
        address: "Rua das mexiricas, 222",
        email: "rlsp@gmail.com",
        cpf: "23123123",
        age: 12
      }

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
