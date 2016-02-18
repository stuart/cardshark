defmodule BlackJack do
  use Application

  def start do
    start([], [])
  end

  def start(_type, options) do
    BlackJack.GameSup.start_link(options)
  end
end
