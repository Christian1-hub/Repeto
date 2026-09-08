defmodule RepetoWeb.PageController do
  use RepetoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
