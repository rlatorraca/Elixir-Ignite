defmodule DeliverElixir.Users.AgentTest do
  use ExUnit.Case
  alias DeliverElixir.Users.Agent, as: UserAgent

  import DeliverElixir.Factory

  describe "save/1" do
    test "the ability of save an user" do
      user = build(:user)

      UserAgent.start_link({})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})
      cpf = "741258963"
      {:ok, cpf: cpf}
    end

    test "check out if an user is saved, returns the user wanted", %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response =
        {:ok,
         %DeliverElixir.Users.User{
           address: "Rua das mandiocas,n. 1022, Bairro Comercial 1",
           age: 45,
           cpf: "741258963",
           email: "rlsp@gmail.com",
           name: "Rodrigo L S Pires"
         }}

      assert response == expected_response
    end

    test "check out if an user is not saved, returns an error" do
      response = UserAgent.get("1010101010")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
