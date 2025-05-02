defmodule Onboardnew.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OnboardnewWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:onboardnew, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Onboardnew.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Onboardnew.Finch},
      # Start a worker by calling: Onboardnew.Worker.start_link(arg)
      # {Onboardnew.Worker, arg},
      # Start to serve requests, typically the last entry
      OnboardnewWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Onboardnew.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OnboardnewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
