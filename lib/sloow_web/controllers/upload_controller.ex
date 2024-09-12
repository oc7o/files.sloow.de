defmodule SloowWeb.UploadController do
  use SloowWeb, :controller

  def upload(conn, _params) do
    render(conn, :upload)
  end
end
