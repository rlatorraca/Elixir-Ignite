defmodule DeliverElixir.Orders.ReportTest do
  use ExUnit.Case

  alias DeliverElixir.Orders.Agent, as: OrderAgent
  alias DeliverElixir.Orders.Report
  # alias DeliverElixir.Orders.Order , as: NOME

  import DeliverElixir.Factory

  describe "create/1" do
    test "creates a report in a .cvs file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      expected_response =
        "14785236978,pizza,3,10.55,meat,4,23.45,125.45\n" <>
          "14785236978,pizza,3,10.55,meat,4,23.45,125.45\n14785236978,pizza,3,10.55,meat,4,23.45,125.45\n"

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
