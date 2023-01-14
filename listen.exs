defmodule Listen do
  alias Snitch.{User, Email, Mailer}

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

        Email.welcome_email()
        |> Mailer.deliver_now()

        listen_for_messages()
    end
  end
end

{:ok, connection} = AMQP.Connection.open()
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Queue.declare(channel, System.get_env("QUEUE"))
AMQP.Basic.consume(channel, System.get_env("QUEUE"), nil, no_ack: true)
IO.puts(" [*] Listening for messages")

Listen.listen_for_messages()
