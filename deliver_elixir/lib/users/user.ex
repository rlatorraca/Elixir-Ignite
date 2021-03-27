defmodule DeliverElixir.Users.User do
  #  Structs example => e um MAPA com um NOME
  ## usamos apra envelopar os dados e transportar de um lado par aoutro (como classe ou model)
  defstruct [:name, :email, :cpf, :age]

  # Structs with mandatory fields
  # @keys [:name, :email, :cpf, :age]
  # @enforce_keys @keys
  # defstruct @keys

  # Common practice: create a build function to populate a structs
  # guard : age > 18 years old AND cpf has tobe a string (not numeric)
  def build(name, email, cpf, age) when age > 17 and is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       name: name,
       email: email,
       cpf: cpf,
       age: age
     }}
  end

  def build(_name, _email, _cpf, _age), do: {:error, "Invalid parameters"}
end
