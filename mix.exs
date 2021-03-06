defmodule Xqlite.MixProject do
  use Mix.Project

  @name "Xqlite"
  @version "0.1.0"

  def project do
    [
      app: :xqlite,
      version: @version,
      elixir: "~> 1.9",
      name: @name,
      start_permanent: Mix.env() == :prod,
      docs: docs(),
      deps: deps(),
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: rustler_crates(),

      # hex
      description: description(),
      package: package(),

      # testing
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.circle": :test
      ],

      # type checking
      dialyzer: dialyzer(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Xqlite.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # dependencies that are always included.

      {:db_connection, "~> 2.0"},
      {:decimal, "~> 1.8"},
      {:ecto_sql, "~> 3.1"},
      {:floki, "~> 0.23"},
      {:jason, "~> 1.1", optional: true},
      {:rustler, "~> 0.21"},
      {:sqlitex,
       github: "elixir-sqlite/sqlitex", ref: "1049a2c8cf88cd0e12e56f1f4cbed1bd4dc3283e"},

      # dev / test dependencies.

      {:benchee, "~> 1.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0-rc", only: :dev, runtime: false},
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},
      {:excoveralls, "~> 0.11", only: :test}
    ]
  end

  defp docs(),
    do: [
      source_ref: "v#{@version}",
      main: "readme",
      extras: ["README.md"]
    ]

  defp rustler_crates(), do: [xqlite_rusqlitenif: [mode: :release]]

  defp description(), do: "SQLite3 library and an adapter for Ecto 3.1+ in one package"

  defp package() do
    [
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/dimitarvp/xqlite",
        "Hexdocs" => "https://hexdocs.pm/xqlite"
      }
    ]
  end

  defp dialyzer(_) do
    [plt_add_apps: [:jason]]
  end
end
