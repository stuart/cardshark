defmodule BlackJack.Player do
  use GenServer

  defstruct hand: [], chips: 0

  def start_link(chips) do
    GenServer.start_link __MODULE__, %BlackJack.Player{chips: chips}
  end

  def hand(player) do
    GenServer.call player, :hand
  end

  def chips(player) do
    GenServer.call player, :chips
  end

  def bid(player, chips) do
    GenServer.cast player, {:pay, -chips}
  end

  def pay(player, chips) do
    GenServer.cast player, {:pay, chips}
  end

  def add_card(player, card) do
    GenServer.cast player, {:add_card, card}
  end

  # Genserver callbacks
  def handle_call :hand, _from, state do
    {:reply, state.hand, state}
  end

  def handle_call :chips, _from, state do
    {:reply, state.chips, state}
  end

  def handle_cast {:pay, chips}, state do
    {:noreply, %BlackJack.Player{state | chips: state.chips + chips}}
  end

  def handle_cast {:add_card, card}, state do
    {:noreply,  %BlackJack.Player{state | hand: [card | state.hand]}}
  end
end