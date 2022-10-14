defmodule HelloWeb.LayoutView do
  use HelloWeb, :view

  #rendering templates function into template, becuase templates are compiled inside the view
  def title() do
    "Awesome New Title!"
  end

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
end
