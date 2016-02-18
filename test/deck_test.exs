defmodule DeckTest do
  use ExUnit.Case

  alias BlackJack.Deck

  def is_a_card(card) do
    Enum.member?(Deck.cards, card)
  end

  setup do
    {:ok, deck} = Deck.start_link
    {:ok, deck: deck}
  end

  test "list of cards" do
    assert 52 = length(Deck.cards)
    assert [card | _ ]= Deck.cards
    assert is_a_card(card)
  end

  test "can take a card from the deck", ctx do
    assert is_a_card(Deck.draw(ctx[:deck]))
  end

  test "drawing 52 cards refreshes the deck", ctx do
    for _ <- (1..56), do: assert is_a_card(Deck.draw(ctx[:deck]))
  end

  test "can re-shuffle the deck", ctx do
    Deck.draw ctx[:deck]
    Deck.draw ctx[:deck]
    Deck.shuffle ctx[:deck]
    assert Deck.count(ctx[:deck]) == 52
  end

  test "can create decks with more than one 52 card set" do
    {:ok, deck} = Deck.start_link(4)
    Deck.shuffle deck
    assert Deck.count(deck) == 208
  end
end