defmodule Snitch.Email do
  import Bamboo.Email

  def welcome_email(name) do
    new_email(
      to: "zenga.siwingwa@northmead.co",
      from: "admin@northmead.co",
      # to: System.get_env("TO_EMAIL"),
      # from: System.get_env("FROM_EMAIL"),
      subject: "Wohoo! #{name} just joined!",
      html_body: "<strong>#{name}</strong> has recently signed up for an account!",
      text_body: "The EE Family Is Growing"
    )
  end
end
