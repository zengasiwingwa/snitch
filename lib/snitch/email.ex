defmodule Snitch.Email do
  import Bamboo.Email

  def welcome_email do
    new_email(
      to: System.get_env("TO_EMAIL"),
      from: System.get_env("FROM_EMAIL"),
      subject: "Wohoo! New User Alert! ",
      html_body: "We have a new new<strong>User</strong> in the house!",
      text_body: "Thanks for joining!"
    )
  end
end
