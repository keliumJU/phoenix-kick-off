defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    #example disable layour main
    #conn
    #|> put_root_layout(false)
    #|> render("index.html")

    #example renderin other layour
    #conn
    #|> put_root_layout("admin.html")
    #|> render("index.html")

    #example overriding rendering formats(text, json, ...)
    #http://localhost:4000/?_format=text
    #render(conn, :index)

    #sending responses directly, with specefic type
    #conn
    #|> put_resp_content_type("text/plain")
    #|> send_resp(201, "lola")

    #setting the HTTP status
    #conn
    #|> put_status(202)
    #|> render("index.html")

    #redirect example
    #redirect(conn, to: "/redirect_test")
    #redirect(conn, external: "https://elixir-lang.org/")
    #page path is the route identifier

    #flash messages and redirect
    conn
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> redirect(to: Routes.page_path(conn, :redirect_test))

    #render(conn, "index.html")
  end

  def redirect_test(conn, _params) do
    render(conn, "index.html")
  end

  #Rendering JSON directly from controller
  def show(conn, _params) do
    page = %{title: "foo"}
    render(conn, "show.json", page: page)
  end
end
