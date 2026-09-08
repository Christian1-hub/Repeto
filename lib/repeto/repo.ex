defmodule Repeto.Repo do
  use Ecto.Repo,
    otp_app: :repeto,
    adapter: Ecto.Adapters.Postgres
end
