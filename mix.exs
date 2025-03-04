defmodule AuthService.MixProject do
  use Mix.Project

  def project do
    [
      app: :auth_service,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # HTTP server
      {:plug_cowboy, "~> 2.6"},
      # Redis client
      {:redix, "~> 1.2"},
      # gRPC support
      {:grpc, "~> 0.6.0"},
      {:protobuf, "~> 0.14.1"}
    ]
  end

  defp elixirc_paths(:dev), do: ["lib", ".formatter_plugins"]
  defp elixirc_paths(_), do: ["lib"]
end
