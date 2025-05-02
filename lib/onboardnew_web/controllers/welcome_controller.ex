defmodule OnboardnewWeb.WelcomeController do
  use OnboardnewWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
