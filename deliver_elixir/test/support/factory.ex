defmodule DeliverElixir.Factory do
  use ExMachina

  alias DeliverElixir.Users.User

  def user_factory do
    %User{
      name: "Rodrigo L S Pires",
      address: "Rua das mandiocas,n. 1022, Bairro Comercial 1",
      email: "rlsp@gmail.com",
      cpf: "14785236978",
      age: 45
    }
  end
end
