defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @available_plates [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"

  ]

  def build (filename) do



    # Version 3 / 4
    filename
      |> Parser.parse_file()
      |> Enum.reduce(report_accumulator(), fn line, report ->
          sum_values(line, report)
        end)
  end

  # Version 4
  defp sum_values( [id, food_name, price], %{ "plates" => plates, "users" => users } = report) do
    users = Map.put(users, id, users[id] + price)
    plates = Map.put(plates, food_name, plates[food_name] + 1)

    # Style 01 => to put on Map
    # report
    #   |> Map.put("users",users)
    #   |> Map.put("plates", plates)

    %{ report | "users" => users, "plates" => plates}
  end

  # Version 2.2 / 2.3 / 2/4/ 3 / 4
  defp report_accumulator do
    plates = Enum.into(@available_plates, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    %{  "plates" => plates, "users" => users}
  end

  # Return the user that spent more money in purchases
  def fetch_higher_cost(report), do: Enum.max_by(report, fn {_key, value} -> value end )
end
