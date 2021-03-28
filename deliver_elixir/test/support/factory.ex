defmodule DeliverElixir.Factory do
  use ExMachina

  alias DeliverElixir.Orders.Item
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

  def item_factory do
    %Item{
      description: "Pizza de Mussarela",
      category: :pizza,
      unity_price: Decimal.new("10.55"),
      quantity: 3
    }
  end
end
