defmodule ReportsGeneratorChallenge do
  alias ReportsGeneratorChallenge.Parser

  @names [
    "daniele",
    "mayk",
    "giuliano",
    "cleiton",
    "jakeliny",
    "joseph",
    "diego",
    "rafael",
    "vinicius",
    "danilo"
  ]

  @months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @filename "reports/gen_report.csv"

  def build() do
    @filename
    |> Parser.parse_file()
    |> Enum.reduce(report_accumulator(), fn line, report ->
      sum_values(line, report)
    end)
  end

  defp sum_map(map, id, date, hours),
    do: put_in(map[id], Map.put(map[id], date, map[id][date] + hours))

  defp sum_values(
         [id, hours_worked, _day, month, year],
         %{
           "all_hours" => all_hours,
           "hours_per_month" => hours_per_month,
           "hours_per_year" => hours_per_year
         }
       ) do
    all_hours = Map.put(all_hours, id, all_hours[id] + hours_worked)
    hours_per_month = sum_map(hours_per_month, id, month, hours_worked)
    hours_per_year = sum_map(hours_per_year, id, year, hours_worked)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp report_accumulator do
    month_list = Enum.into(@months, %{}, &{&1, 0})
    year_list = Enum.into(2016..2021, %{}, &{&1, 0})

    %{"all_hours" => %{}, "hours_per_month" => %{}, "hours_per_year" => %{}}
    |> Map.put("all_hours", accumulator_id_map_generator(0))
    |> Map.put("hours_per_month", accumulator_id_map_generator(month_list))
    |> Map.put("hours_per_year", accumulator_id_map_generator(year_list))
  end

  defp accumulator_id_map_generator(value), do: Enum.into(@names, %{}, &{&1, value})

  defp build_reports(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
