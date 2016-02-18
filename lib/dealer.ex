defmodule BlackJack.Dealer do
  use GenServer

  defstruct current_game: nil, player_sup: nil

  def start_link() do
    GenServer.start_link __MODULE__, []
  end

  def handle_call :new_game, _from, state do

  end
end