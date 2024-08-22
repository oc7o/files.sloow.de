defmodule Sloow.Repo do
  use Ecto.Repo,
    otp_app: :sloow,
    adapter: Ecto.Adapters.Postgres
end
