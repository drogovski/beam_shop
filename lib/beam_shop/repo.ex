defmodule BeamShop.Repo do
  use Ecto.Repo,
    otp_app: :beam_shop,
    adapter: Ecto.Adapters.Postgres
end
