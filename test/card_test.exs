defmodule CardTest do
  use ExUnit.Case

  alias BlackJack.Card

  test "Points value for non face cards" do
    assert Card.points({2, :spades}) == 2
    assert Card.points({3, :clubs}) == 3
    assert Card.points({4, :hearts}) == 4
    assert Card.points({5, :diamonds}) == 5
    assert Card.points({6, :spades}) == 6
    assert Card.points({7, :spades}) == 7
    assert Card.points({8, :spades}) == 8
    assert Card.points({9, :spades}) == 9
    assert Card.points({10, :spades}) == 10
  end

  test "Points value for face cards" do
    assert Card.points({"J", :spades}) == 10
    assert Card.points({"Q", :spades}) == 10
    assert Card.points({"K", :spades}) == 10
  end

  test "Points value for ace" do
    assert Card.points({"A", :diamonds}) == 1
  end
end