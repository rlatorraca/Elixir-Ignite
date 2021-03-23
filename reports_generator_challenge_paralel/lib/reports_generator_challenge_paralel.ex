defmodule ReportsGeneratorChallengeParalel do
  alias ReportsGeneratorChallengeParalel.Parser

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
 

   def build_paralel(filenames) when not is_list(filenames) do
    {:error, "Please enter a list of files to be processed"}
  end

  def build_paralel(filenames) do
    result = 
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(report_accumulator(), fn {:ok, result_report}, old_report ->
        sum_reports(old_report, result_report)
      end)
      {:ok, result}
  end

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_accumulator(), fn line, report ->
      sum_values(line, report)
    end)
  end

  defp sum_reports(%{
           "all_hours" => old_all_hours,
           "hours_per_month" => old_hours_per_month,
           "hours_per_year" => old_hours_per_year
         }, %{
           "all_hours" => new_all_hours,
           "hours_per_month" => new_hours_per_month,
           "hours_per_year" => new_hours_per_year
       }) do
    all_hours = merge_maps_reports(old_all_hours, new_all_hours)
    hours_per_year = merge_maps_reports_complex(old_hours_per_year, new_hours_per_year)
    hours_per_month = merge_maps_reports_complex(old_hours_per_month, new_hours_per_month)
    
   
   # %{"plates" => plates, "users" => users}
    build_reports(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_maps_reports(map01, map02) do
    
	  Map.merge(map01, map02, fn _key, value01, value02 -> value01 + value02 end)
	end

	 defp merge_maps_reports_complex(map01, map02) do
		Map.merge(map01, map02, fn _key, value01, value02 -> 
			Map.merge(value01, value02, fn _key, value03, value04 -> value03 + value04 end) 
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
