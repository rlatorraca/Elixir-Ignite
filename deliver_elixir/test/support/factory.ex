defmodule DeliverElixir.Factory do
  use ExMachina

  alias DeliverElixir.Orders.{Item, Order}
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

  def order_factory do
    %Order{
      delivery_address: "Rua das mandiocas,n. 1022, Bairro Comercial 1",
      items: [
        build(:item),
        build(:item,
          description: "Bife a cavalo",
          category: :meat,
          quantity: 4,
          unity_price: Decimal.new("23.45")
        )
      ],
      total_price: Decimal.new("125.45"),
      user_cpf: "14785236978"
    }
  end
end
