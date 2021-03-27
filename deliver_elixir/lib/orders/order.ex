defmodule DeliverElixir.Orders.Order do
  # Keys to validation
  @keys [:user_cpf, :user_address, :items, :total_price]

  @enforce_keys @keys
  defstruct @keys

  def build do
    {:ok, %__MODULE__{user_cpf: nil, user_address: nil, items: nil, total_price: nil}}
  end
end
