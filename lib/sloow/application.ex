defmodule Sloow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SloowWeb.Telemetry,
      Sloow.Repo,
      {DNSCluster, query: Application.get_env(:sloow, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Sloow.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Sloow.Finch},
      # Start a worker by calling: Sloow.Worker.start_link(arg)
      # {Sloow.Worker, arg},
      # Start to serve requests, typically the last entry
      SloowWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sloow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SloowWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
