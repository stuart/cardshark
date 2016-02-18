defmodule BlackJack.Card do
  def points({value, suit}) when value <= 10 do
    value
  end

  def points({value, suit})
    when value == "J" or value == "Q" or value == "K" do
    10
  end

  def points({"A", suit}) do
    1
  end
end