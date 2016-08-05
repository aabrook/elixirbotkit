defmodule ElixirBotTest do
  use ElixirBotKit

  heard "_ (.*)", tokens do
    Enum.at(tokens, 1)
  end

  heard "good things", _ do
    "I heard some good things"
  end
end

defmodule ElixirBotKitTest do
  use ExUnit.Case
  doctest ElixirBotKit

  test "that the heard macro picks up all" do
    assert Enum.count(ElixirBotTest.heard) == 2
  end

  test "that regex's are atoms", _ do
    assert apply(ElixirBotTest, String.to_atom("good things"), [['a', 'b']]) == "I heard some good things"
  end

  test "that we get the right heard function" do
    caller = self
    :meck.new(Slack.Sends)

    :meck.expect(Slack.Sends, :send_message, fn(result, _, _) -> 
      send caller, :called! 
    end)
    ElixirBotTest.handle_message(%{type: "message", text: "_ catch this", channel: {}}, {})

    assert_receive :called!, 10
    :meck.unload(Slack.Sends)
  end

  test "test we get the right heard result" do
    caller = self
    :meck.new(Slack.Sends)

    :meck.expect(Slack.Sends, :send_message, fn(result, _, _) -> 
      if result == "catch this" do 
        send caller, :called!
      else 
        send caller, :failed! 
      end
    end)
    ElixirBotTest.handle_message(%{type: "message", text: "_ catch this", channel: {}}, {})

    assert_receive :called!, 10
    :meck.unload(Slack.Sends)
  end

  test "test we don't get a result" do
    caller = self
    :meck.new(Slack.Sends)

    :meck.expect(Slack.Sends, :send_message, fn(result, _, _) -> 
      send caller, :called!
    end)
    ElixirBotTest.handle_message(%{type: "message", text: "ignore this", channel: {}}, {})

    refute_receive :called!, 10
    :meck.unload(Slack.Sends)
  end
end
