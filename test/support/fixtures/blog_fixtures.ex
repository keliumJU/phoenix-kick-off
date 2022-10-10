defmodule Hello.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> Hello.Blog.create_post()

    post
  end
end
