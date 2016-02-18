defmodule BlackJack.Deck do
  use GenServer
  alias BlackJack.Card

  def start_link(num_decks \\ 1) do
    GenServer.start_link(__MODULE__, {[], num_decks})
  end

  def cards do
     suits = [:spades, :hearts, :diamonds, :clubs]
     values = ["A",2,3,4,5,6,7,8,9,10,"J","Q","K"]
     for s <- suits, v <- values, do: {v, s}
  end

  def draw deck do
    GenServer.call(deck, :draw)
  end

  def shuffle deck do
    GenServer.cast(deck, :shuffle)
  end

  def count deck do
    GenServer.call(deck, :count)
  end

  # GenServer Callbacks
  def handle_call :draw, _from, {[card | deck], num_decks} do
    {:reply, card, {deck, num_decks}}
  end

  def handle_call :draw, _from, {[], num_decks} do
    [card | deck] = shuffled_cards(num_decks)
    {:reply, card, {deck, num_decks}}
  end

  def handle_call :count, _from, {deck, num_decks} do
    {:reply, length(deck), {deck, num_decks}}
  end

  def handle_cast :shuffle, {_, num_decks} do
    {:noreply, {shuffled_cards(num_decks), num_decks}}
  end

  defp shuffled_cards(num_decks) do
    List.duplicate(cards, num_decks)
      |> List.flatten
      |> Enum.shuffle
  end
end