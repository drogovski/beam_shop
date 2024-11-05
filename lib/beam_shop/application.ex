defmodule BeamShop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BeamShopWeb.Telemetry,
      BeamShop.Repo,
      {DNSCluster, query: Application.get_env(:beam_shop, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BeamShop.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BeamShop.Finch},
      # Start a worker by calling: BeamShop.Worker.start_link(arg)
      # {BeamShop.Worker, arg},
      # Start to serve requests, typically the last entry
      BeamShopWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BeamShop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BeamShopWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
