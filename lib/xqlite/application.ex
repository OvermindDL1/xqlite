defmodule Xqlite.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = []

    opts = [strategy: :one_for_one, name: Xqlite.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
