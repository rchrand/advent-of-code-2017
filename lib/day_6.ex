defmodule AdventOfCode2017.Day6 do
  @_input "11 11 13 7 0 15 5 5 4 4 1 1 7 1 15 11"

  def call(input \\ @_input) do
    input
    |> parse_input
    |> setup
    |> setup_ets
    |> rebalance(1)
  end

  defp rebalance(configuration, step) do
    {index, value} = Enum.max_by(configuration, fn {_, value} -> value end)

    new_config = increment(index + 1, index, value, configuration)
    :ets.insert(:configuration, {step, new_config})

    if recurring_configuration?(step) do
      "It took #{step} steps to recur!"
    else
      rebalance(new_config, step + 1)
    end
  end

  defp increment(_, _, 0, configuration) do
    configuration
  end
  defp increment(new_index, org_index, 1, configuration) when new_index == org_index do
    configuration
  end
  defp increment(new_index, org_index, value, configuration) when new_index == org_index do
    increment(new_index + 1, org_index, value, configuration)
  end
  defp increment(new_index, org_index, value, configuration) when new_index == map_size(configuration) do
    increment(0, org_index, value, configuration)
  end
  defp increment(new_index, org_index, value, configuration) do
    {i, v} = Enum.at(configuration, new_index)

    new_config = %{ configuration | i => v + 1, org_index => value - 1}

    increment(new_index + 1, org_index, value - 1, new_config)
  end

  defp recurring_configuration?(1), do: false
  defp recurring_configuration?(2) do
    [{_, first_configuration}] = :ets.lookup(:configuration, 1)
    [{_, second_configuration}] = :ets.lookup(:configuration, 2)

    first_configuration == second_configuration
  end
  defp recurring_configuration?(step) do
    [{_, latest_configuration}] = :ets.lookup(:configuration, step)

    Enum.any?((1..step - 1), fn i ->
      [{_, config}] = :ets.lookup(:configuration, i)
      config == latest_configuration
    end)
  end

  defp setup(configuration) do
    Enum.reduce((0..length(configuration) - 1), %{}, fn i, acc ->
      Map.merge(acc, %{i => Enum.at(configuration, i)})
    end)
  end

  defp setup_ets(config) do
    :ets.new(:configuration, [:named_table])

    config
  end

  defp parse_input(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
