defmodule ElixirBotKit.Mixfile do
  use Mix.Project

  def project do
    [app: :elixirbotkit,
     version: "0.5.0",
     description: "A Slack bot extension that hears what you ask",
     package: package,
     elixir: "~> 1.2",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :slack]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:slack, "~>0.7.0"}, {:meck, "~> 0.8.4", only: :test},{:ex_doc, ">= 0.0.0", only: :dev}]
  end
  defp package do
    [
     name: :elixirbotkit,
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Aaron Abrook"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/aabrook/elixirbotkit"}]
  end
end
