defmodule ElixirBotKit do
  defmacro __using__(_opts) do
    quote do
      use Slack
      import ElixirBotKit 

      @heard []

      def handle_message(message = %{type: "message"}, slack) do
        Enum.each heard, fn {name, desc} ->
          {:ok, reg} = Regex.compile(desc)

          if(Regex.match?(reg, message[:text])) do
            result = apply(__MODULE__, name, [Regex.run(reg, message[:text])])

            IO.puts("Result: " <> result)

            send_message(result, message.channel, slack)
          end
        end
      end
      def handle_message(_,_), do: :ok

      @before_compile ElixirBotKit
    end
  end

  defmacro heard(description, tokens, do: block) do
    function_name = String.to_atom(description)

    quote do
      @heard [{unquote(function_name), unquote(description)} | @heard]

      def unquote(function_name)(unquote(tokens)) do
        unquote(block)
      end

    end
  end

  defmacro __before_compile__(env) do
    quote do
      def heard, do: @heard
    end
  end
end
