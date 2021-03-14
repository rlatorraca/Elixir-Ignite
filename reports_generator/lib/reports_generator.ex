defmodule ReportsGenerator do

  def build (filename) do

    """
    Mode 1
    case File.read("reports/#{filename}") do
      {:ok, result} -> result
      {:error, reason} -> reason
      _ -> "any other issue"
    end
    """

    # Mode 2
    "reports/#{filename}"
      |> File.read()
      |> handle_file("Second argument")

  end

  defp handle_file({:ok, file_content}, msg), do: file_content <> " => " <> msg
  defp handle_file({:error, _reason}, msg), do: "Error while opening file !!! " <> msg
end
