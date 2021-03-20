defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build_paralel/1" do
    test "building a readeable report using parelal processing getting 2 or more files" do
      # SET UP
      file_names = ["report_test.csv", "report_test.csv", "report_test.csv"]

      # EXCERCISE
      response = ReportsGenerator.build_paralel(file_names)

      expected_response =
        {:ok,
         %{
           "plates" => %{
             "açaí" => 3,
             "churrasco" => 6,
             "esfirra" => 9,
             "hambúrguer" => 6,
             "pastel" => 0,
             "pizza" => 6,
             "prato_feito" => 0,
             "sushi" => 0
           },
           "users" => %{
             "1" => 144,
             "10" => 108,
             "11" => 0,
             "12" => 0,
             "13" => 0,
             "14" => 0,
             "15" => 0,
             "16" => 0,
             "17" => 0,
             "18" => 0,
             "19" => 0,
             "2" => 135,
             "20" => 0,
             "21" => 0,
             "22" => 0,
             "23" => 0,
             "24" => 0,
             "25" => 0,
             "26" => 0,
             "27" => 0,
             "28" => 0,
             "29" => 0,
             "3" => 93,
             "30" => 0,
             "4" => 126,
             "5" => 147,
             "6" => 54,
             "7" => 81,
             "8" => 75,
             "9" => 72
           }
         }}

      # ASSERTION
      assert response == expected_response
    end
  end

  describe "build/1" do
    test "building a readeable report" do
      # SET UP
      file_name = "report_test.csv"

      # EXCERCISE
      response = ReportsGenerator.build(file_name)

      expected_response = %{
        "plates" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      # ASSERTION
      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is 'users', return the user_id of best shopper" do
      # SET UP
      file_name = "report_test.csv"

      # EXERCISE
      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      # ASSERTATION

      assert response == expected_response
    end

    test "when the option is 'plates', return the most purchased plate" do
      # SET UP
      file_name = "report_test.csv"

      # EXERCISE
      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("plates")

      expected_response = {:ok, {"esfirra", 3}}

      # ASSERTATION

      assert response == expected_response
    end

    test "when the option is invalid is given, return a ERROR and a Message" do
      # SET UP
      file_name = "report_test.csv"

      # EXERCISE
      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("")

      expected_response = {"error", "Invalid option!"}

      # ASSERTATION

      assert response == expected_response
    end
  end
end
