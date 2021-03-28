defmodule DeliverElixir.Users.UserTest do
  use ExUnit.Case
  alias DeliverElixir.Users.User

  describe "build/5" do
    test "if all parameters are valid ones, return instance of user" do
      response =
        User.build(
          "Rodrigo L S Pires",
          "Rua das mandiocas,n. 1022, Bairro Comercial 1",
          "rlsp@gmail.com",
          "14785236978",
          45
        )

      expected_response =
        {:ok,
         %User{
           address: "Rua das mandiocas,n. 1022, Bairro Comercial 1",
           age: 45,
           cpf: "14785236978",
           email: "rlsp@gmail.com",
           name: "Rodrigo L S Pires"
         }}

      assert response == expected_response
    end

    test "if all parameters are not valid ones, return an error" do
      response =
        User.build(
          "Rodrigo L S Pires",
          "Rua das mandiocas,n. 1022, Bairro Comercial 1",
          "rlsp@gmail.com",
          "14785236978",
          10
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
