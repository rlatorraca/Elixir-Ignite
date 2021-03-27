defmodule DeliverElixir.Orders.Order do
  alias DeliverElixir.Orders.Item
  alias DeliverElixir.Users.User

  # Keys to validation
  @keys [:user_cpf, :delivery_address, :items, :total_price]

  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total_delivery(items)
     }}
  end

  def build(_user, _items), do: {:error, "Invalid Parameters in Order"}

  def calculate_total_delivery(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{unity_price: price, quantity: quantity}, acc) do
    price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
