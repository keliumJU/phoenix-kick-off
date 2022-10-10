defmodule HelloWeb.HelloController do
  use HelloWeb, :controller
  #Plug in controller
  plug HelloWeb.Plugs.Locale, "de" when action in [:index]


  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    #example with only text, nothing of html
    #text(conn, "From messenger #{messenger}")

    #example rendering json
    #json(conn, %{id: messenger})
    render(conn, "show.html", messenger: messenger)
  end
end
