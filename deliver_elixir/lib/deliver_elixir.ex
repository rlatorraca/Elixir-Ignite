defmodule DeliverElixir do
  alias DeliverElixir.Orders.Agent, as: OrderAgent
  alias DeliverElixir.Orders.CreateOrUpdate, as: CreateOrUpdateOrders
  alias DeliverElixir.Users.Agent, as: UserAgent
  alias DeliverElixir.Users.CreateOrUpdate, as: CreateOrUpdateUsers

  # Design Patterns => FACADE
  defdelegate create_or_update_user(params), to: CreateOrUpdateUsers, as: :call
  defdelegate create_or_update_order(params), to: CreateOrUpdateOrders, as: :call

  def starts_agents do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end
end
