defmodule BlackJack.GameSup do
  use Supervisor

  def start_link(options) do
    Supervisor.start_link __MODULE__, options
  end

  def init(options) do
    children = [
      worker(BlackJack.Dealer, []),
      worker(BlackJack.PlayerSup, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end