defmodule SloowWeb.HelloController do
  use SloowWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
