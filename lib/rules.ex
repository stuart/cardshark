defmodule BlackJack.Rules do
  alias BlackJack.Card

  def hand_value hand, aces \\ :low do
    Enum.reduce(hand, 0, fn(card, total) -> total + add_card(card, aces) end)
  end

  defp add_card({"A", _} = card, :high) do
    Card.points(card) + 10
  end

  defp add_card(card, _) do
    Card.points(card)
  end

  def blackjack?(hand) when length(hand) == 2 do
    hand_value(hand, :high) == 21
  end

  def blackjack?(_) do
    false
  end

  def busted? hand do
    hand_value(hand, :low) > 21
  end

  def five_cards_under?(hand) when length(hand) >= 5 do
    hand_value(hand, :low) <= 21
  end

  def five_cards_under?(_) do
    false
  end

  def better_hand hand, other do
    compare_hands(hand_value(hand), hand_value(other),
                  blackjack?(hand), blackjack?(other),
                  five_cards_under?(hand), five_cards_under?(other))
  end

  defp compare_hands(_, _, :true, _, _, _) do
    true
  end

  defp compare_hands(_, _, :false, :true, _, _) do
    false
  end

  defp compare_hands(_, _, _, _, :true, _) do
    true
  end

  defp compare_hands(_, _, _, _, :false, :true) do
    false
  end

  defp compare_hands(v1, _, _, _, _, _) when v1 > 21 do
    false
  end

  defp compare_hands(_, v2, _, _, _, _) when v2 > 21 do
    true
  end

  defp compare_hands(v1, v2, _, _, _, _) do
    v1 >= v2
  end
end