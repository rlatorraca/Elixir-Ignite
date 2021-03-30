defmodule DeliverElixir do
  alias DeliverElixir.Users.Agent, as: UserAgent
  alias DeliverElixir.Users.CreateOrUpdate

  # Design Patterns => FACADE
  defdelegate create_or_update_user(params), to: CreateOrUpdate, as: :call

  def starts_agents do
    UserAgent.start_link(%{})
  end
end
