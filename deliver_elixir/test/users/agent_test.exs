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
    test "check out if an user is saved, returns the user wanted" do
      UserAgent.start_link({})

      :user
      |> build(cpf: "741258963")
      |> UserAgent.save()

      response = UserAgent.get("741258963")

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
      UserAgent.start_link({})

      response = UserAgent.get("1010101010")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
