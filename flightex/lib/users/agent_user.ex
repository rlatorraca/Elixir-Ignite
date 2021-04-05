defmodule Flightex.Users.Agent do
  use Agent
  alias Flightex.Users.User

  def start_link(_initial_state) do
    Agent.start(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, order, uuid))
    {:ok, uuid}
  end:

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  # & &1 => retorna todos os ESTADOS (todos usuarios)
  def list_all, do: Agent.get(__MODULE__, & &1)

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{cpf: cpf} = user), do: Map.put(state, cpf, user)
end
