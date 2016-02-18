defmodule PlayerTest do
  use ExUnit.Case

  alias BlackJack.Player

  setup do
    {:ok, player} = Player.start_link(10)
    {:ok, player: player}
  end

  test "hand shows the cards in the hand", ctx do
    assert [] = Player.hand ctx[:player]
  end

  test "chips returns a number of chips", ctx do
    assert 10 = Player.chips ctx[:player]
  end

  test "bid removes a number of chips", ctx do
    Player.bid(ctx[:player], 5)
    assert 5 = Player.chips(ctx[:player])
  end

  test "pay adds number of chips", ctx do
    Player.pay(ctx[:player], 5)
    assert 15 = Player.chips(ctx[:player])
  end
end