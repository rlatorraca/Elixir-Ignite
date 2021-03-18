defmodule ReportsGenerator do
  alias ReportsGenerator.Parser
  def build (filename) do

   
    # Version 3 / 4
    filename
      |> Parser.parse_file()
      |> Enum.reduce(report_accumulator(), fn line, report -> 
          sum_values(line, report)
        end)
  end

  # Version 4
  defp sum_values( [id, _food_name, price], report), do: Map.put(report, id, report[id] + price)

  # Version 2.2 / 2.3 / 2/4/ 3
  defp report_accumulator, do: Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

  # Return the user that spent more money in purchases
  def fetch_higher_cost(report), do: Enum.max_by(report, fn {_key, value} -> value end )
end
