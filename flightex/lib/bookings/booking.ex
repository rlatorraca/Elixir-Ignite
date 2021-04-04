defmodule Flightex.Bookings.Booking do

  @keys[]


  def build(id, data_completa, cidade_origem, cidade_destino, id_usuario) do
    {:ok, %__MODULE__{
      id: id,
      data_completa: data_completa,
      cidade_origem: cidade_origem,
      cidade_destino: cidade_destino,
      id_usuario: id_usuario
    }}
  end

  def build(_id, _data_completa, _cidade_origem, _cidade_destino, _id_usuario) do
     {:error, "Invalid parameters building a booking"}
  end
end
