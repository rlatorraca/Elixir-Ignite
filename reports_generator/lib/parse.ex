defmodule ReportsGenerator.Parser do

  def parse_file (filename) do

    
    # Version 1
    # case File.read("reports/#{filename}") do
    #   {:ok, result} -> result
    #   {:error, reason} -> reason
    #   _ -> "any other issue"
    # end
    
    # Version 2
    #"reports/#{filename}"
      # Version 2.1
      # |> File.read()
      # |> handle_file("Second argument")
      
      # Version 2.2
      # |> File.stream!()
      # |> Enum.map(fn line -> parse_line(line) end) # &parse_line(&1)

      # Version 2.3
      # |> File.stream!()
      # |> Enum.reduce(report_accumulator(), fn line, report -> 
      #       [id, _foodName, price] = parse_line(line) 
      #       Map.put(report, id, report[id] + price)
      #     end) 

      # Version 2.4 / 3
      "reports/#{filename}"
        |> File.stream!()
        |> Stream.map(fn line -> parse_line(line) end)
        
  end

  # Version 2.1
  # defp handle_file({:ok, file_content}, msg), do: file_content <> " => " <> msg
  # defp handle_file({:error, _reason}, msg), do: "Error while opening file !!! " <> msg

  # Version 2.2 / 2.3 / 2.4 / 3
  defp parse_line(line) do
    line 
      |> String.trim()
      |> String.split(",")
      |> List.update_at(2, &String.to_integer/1) # fn elem -> String.to_integer(elem) end
  end

end
