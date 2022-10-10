defmodule HelloWeb.ArticleController do
  use HelloWeb, :controller

  alias Hello.News
  alias Hello.News.Article

  #if any action does not return a %Plug.Conn{}, we want to invoke FallbackController with the result
  action_fallback HelloWeb.FallbackController

  def index(conn, _params) do
    articles = News.list_articles()
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params}) do
    #special form that ships as part of Elixir allows us to check explicitly for the happy paths
    with {:ok, %Article{} = article} <- News.create_article(article_params) do
      #if News.create_article/1 returns {:error, changeset}, we will simply return {:error, changeset} from the action.
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.article_path(conn, :show, article))
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    article = News.get_article!(id)
    render(conn, "show.json", article: article)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = News.get_article!(id)

    with {:ok, %Article{} = article} <- News.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = News.get_article!(id)

    with {:ok, %Article{}} <- News.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
