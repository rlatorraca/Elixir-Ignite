defmodule DeliverElixir.Users.Agent do
  use Agent

  alias DeliverElixir.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, user, ))
    {:ok, uuid}
  end

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  # & &1 => retorna todos os ESTADOS (todos usuarios)
  def list_all, do: Agent.get(__MODULE__, & &1)

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end

    ## Another way to do same
    # state
    #   |> Map.get(cpf)
    #   |> handle.get()
  end

  # defp handle_get(nil), do: {:error, "USer not found"}
  # defp handle_get(user), do: {:ok, user}

  defp update_state(state, %User{} = user, uuid), do: Map.put(state, user, uuid)
end
