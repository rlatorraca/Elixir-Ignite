defmodule ReportsGeneratorChallenge do
  alias ReportsGeneratorChallenge.Parser

   @available_users [
     "Cleiton",
     "Daniele",
     "Danilo",
     "Diego",
     "Giuliano",
     "Jakeliny",  
     "Joseph",      
     "Mayk",     
     "Rafael",
     "Vinicius"
   ]

   @months [
     "janeiro",
     "fevereiro",
     "março",
     "abril",
     "maior",
     "junho",
     "julho",
     "agosto",
     "setembro",
     "outubro",
     "novemnbro",
     "dezembro"
   ]

   @years [
     "2016",
     "2017",
     "2018",
     "2019",
     "2020",
     "2021",
   ]

  def build(filename) do
  
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_accumulator(), fn line, report ->
      sum_values(line, report)
    end)
  end


  defp sum_values([id, hours_worked, day, month, year], %{"all_hours" => all_hours, "hours_per_month" => hours_per_month, "hours_per_year" => hours_per_year} = report) do
    all_hours = Map.put(all_hours, id, all_hours[id] + hours_worked)
    hours_per_month =  put_in(hours_per_month[id][month], all_hours[month] + hours_worked)
    hours_per_year = put_in(hours_per_year[id][year], hours_per_year[id][year] + hours_worked)

    #plates = Map.put(plates, food_name, plates[food_name] + 1)

    %{report | "all_hours" => all_hours, "hours_per_month" => hours_per_month, "hours_per_years" => hours_per_year}
  end


  defp report_accumulator do
    all_hours= Enum.into(@available_users, %{}, &{&1, 0})
    hours_per_month = Enum.reduce(@available_users, %{ }, fn {name, _value}, acc -> Map.put(acc, name, @months) end)
    hours_per_year = Enum.reduce(@available_users, %{ }, fn {name, _value}, acc -> Map.put(acc, name, @years) end)
    #users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    # %{"plates" => plates, "users" => users}
    build_reports(all_hours, hours_per_month , hours_per_year )
  end


   defp build_reports(all_hours, hours_per_month , hours_per_year ) do
    %{"all_hours" => all_hours, "hours_per_month" => hours_per_month , "hours_per_year" => hours_per_year}
  end
end
