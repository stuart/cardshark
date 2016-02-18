defmodule BlackJackTest do
  use ExUnit.Case
  doctest BlackJack

  test "starting the game" do
    assert {:ok, _pid} = BlackJack.start
  end

  test "a simple one player vs dealer game" do

  end
end
