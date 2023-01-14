defmodule Listen do
  alias Snitch.User

  def listen_for_messages do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts(" [x] Received #{payload}")

        %{
          "id" => id,
          "email" => email,
          "name" => name,
          "password" => password
        } = Jason.decode!(payload)

        user = %User{
          user_id: id,
          name: name,
          email: email,
          password: password
        }

        Snitch.Repo.insert(user)

        listen_for_messages()
    end
  end
end

{:ok, connection} = AMQP.Connection.open()
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Queue.declare(channel, "signup")
AMQP.Basic.consume(channel, "signup", nil, no_ack: true)
IO.puts(" [*] Listening for messages")

Listen.listen_for_messages()
