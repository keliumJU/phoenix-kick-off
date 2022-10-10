defmodule HelloWeb.PageView do
  use HelloWeb, :view

  #Undestanding template compilation, At compile-time, Phoenix precompiles all *.html.heex templates and turns
  #them into render/2 function clauses on their respective view modules.
  #Note: At runtime, all templates are already loaded in memory.
  #def render("index.html", assigns) do
    #"rendering with assigns #{inspect Map.keys(assigns)}"
  #end

  #Rendering json from view
  #def render("index.json", %{pages: pages}) do
  #  %{data: Enum.map(pages, fn page -> %{title: page.title} end)}
  #end

  #def render("show.json", %{page: page}) do
  #  %{data: %{title: page.title}}
  #end

  #Rendering json from view with render_many and render_one
  #def render("index.json", %{pages: pages}) do
  #  %{data: render_many(pages, HelloWeb.PageView, "page.json")}
  #end

  #def render("show.json", %{page: page}) do
  #  %{data: render_one(page, HelloWeb.PageView, "page.json")}
  #end

  #def render("page.json", %{page: page}) do
  #  %{title: page.title}
  #end

  #Note: It's useful to build our views like this so that they are [composable]. Imagine a situation where our page
  #has a has_many relationship...
  alias HelloWeb.AuthorView
  #Note: the name used in assigns is determinated from the view. ex: PageView -> %{page: page}, AuthorView -> %{author: author}
  def render("page_with_authors.json", %{page: page}) do
    %{title: page.title,
      authors: render_many(page.authors, AuthorView, "author.json")
  }
  end

  def render("page.json", %{page: page}) do
    %{title: page.title}
  end

end
