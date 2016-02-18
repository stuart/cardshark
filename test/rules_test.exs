defmodule RulesTest do
  use ExUnit.Case

  alias BlackJack.Rules

  test "hand_value for number cards" do
    assert Rules.hand_value([{3, :clubs}, {5, :diamonds}]) == 8
  end

  test "hand_value including face cards" do
    assert Rules.hand_value([{3, :clubs}, {"K", :diamonds}]) == 13
  end

  test "hand_value including an ace" do
    assert Rules.hand_value([{3, :clubs}, {"A", :diamonds}]) == 4
  end

  test "hand_value with aces high" do
    assert Rules.hand_value([{3, :clubs}, {"A", :diamonds}], :high) == 14
  end

  test "blackjack? when card value != 21" do
    refute Rules.blackjack?([{3, :clubs}, {"K", :diamonds}])
  end

  test "blackjack? when card value == 21" do
    assert Rules.blackjack?([{"A", :clubs}, {"K", :diamonds}])
  end

  test "blackjack? with a 10" do
    assert Rules.blackjack?([{"A", :clubs}, {10, :diamonds}])
  end

  test "blackjack? when there are more than 2 cards" do
    refute Rules.blackjack?([{"A", :clubs}, {5, :diamonds}, {5, :hearts}])
  end

  test "busted? when value > 21" do
    assert Rules.busted?([{"K", :clubs}, {5, :diamonds}, {8, :hearts}])
  end

  test "busted? when value < 21" do
    refute Rules.busted?([{"K", :clubs}, {5, :diamonds}])
  end

  test "busted? with an ace in the hand" do
    refute Rules.busted?([{"A", :clubs}, {6, :diamonds}, {7, :hearts}])
  end

  test "five_cards_under? when there are 5 cards" do
    assert Rules.five_cards_under?([{"A", :clubs},{3, :diamonds}, {4, :hearts}, {6, :diamonds}, {5, :hearts}])
  end

  test "five_cards_under? when 21" do
    assert Rules.five_cards_under?([{"A", :clubs},{3, :diamonds}, {4, :hearts}, {6, :diamonds}, {7, :hearts}])
  end

  test "five_cards_under? when there are fewer cards" do
    refute Rules.five_cards_under?([{"A", :clubs}, {7, :hearts}])
  end

  test "five_cards_under when bust" do
    refute Rules.five_cards_under?([{"A", :clubs},{3, :diamonds}, {4, :hearts}, {6, :diamonds}, {9, :hearts}])
  end

  test "better hand based on values" do
    assert Rules.better_hand [{5, :clubs}, {9, :diamonds}], [{5, :spades}, {8, :diamonds}]
  end

  test "better hand when one is busted" do
    assert Rules.better_hand [{5, :clubs}, {9, :diamonds}], [{9, :hearts}, {5, :spades}, {"K", :diamonds}]
  end

  test "better hand when the first is busted" do
    refute Rules.better_hand [{7, :hearts}, {"K", :clubs}, {9, :diamonds}], [{9, :hearts}, {5, :spades}]
  end

  test "better hand when both are equal" do
    assert Rules.better_hand [{5, :clubs}, {9, :diamonds}], [{5, :spades}, {9, :diamonds}]
  end

  test "better hand when one is BlackJack" do
    refute Rules.better_hand [{5, :clubs}, {9, :diamonds}, {7, :clubs}], [{"A", :spades}, {"Q", :diamonds}]
  end

  test "five_card_under is better than 21 in fewer cards" do
    assert Rules.better_hand [{3, :clubs}, {2, :diamonds}, {7, :clubs}, {2, :diamonds}, {4, :clubs}],
                             [{9, :spades}, {10, :diamonds}, {2, :hearts}]
  end

  test "five_card_under is better than a number in fewer cards" do
    refute Rules.better_hand [{9, :spades}, {5, :diamonds}, {2, :hearts}],
          [{3, :clubs}, {2, :diamonds}, {3, :clubs}, {2, :diamonds}, {4, :clubs}]

  end

  test "BlackJack is better than five cards under" do
    refute Rules.better_hand [{3, :clubs}, {2, :diamonds}, {7, :clubs}, {2, :diamonds}, {4, :clubs}],
                             [{"K", :spades}, {"A", :diamonds}]
  end
end