# Elixirbotkit

An elixir Slack bot extension.

This slack wrapper allows you to create functions that will be called on
when a slack message is received.

#example

```elixir
defmodule YourModule
  use ElixirBotKit

  def start do
    start_link("Your slackbot key")
  end

  heard "a regular expression", tokens do
    # do some things
    "return a result to send to the client"
  end

  heard "another regular expression", tokens do
    # do some more things
    "return another result"
  end
end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add elixirbotkit to your list of dependencies in `mix.exs`:

        def deps do
          [{:elixirbotkit, "~> 0.5.0"}]
        end

  2. Ensure elixirbotkit is started before your application:

        def application do
          [applications: [:elixirbotkit]]
        end

